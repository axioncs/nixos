{ pkgs, ... }:

let
  checkUpdates = pkgs.writeShellApplication {
    name = "check-updates";
    runtimeInputs = with pkgs; [ curl jq yq-go git nix ];
    text = ''
      FLAKE_DIR="$HOME/nixos"
      LLAUNCHER_NIX="$FLAKE_DIR/home/programs/llauncher-pkg.nix"
      HAYASE_NIX="$FLAKE_DIR/home/programs/hayase-pkg.nix"

      notify() {
        local title="$1" body="$2"
        command -v notify-send >/dev/null 2>&1 && notify-send -a "pkg-update-timer" "$title" "$body"
      }

      log() { echo "[pkg-update-timer] $*"; }

      git_commit() {
        local file="$1" message="$2"
        git -C "$FLAKE_DIR" add "$file"
        git -C "$FLAKE_DIR" commit -m "$message" >/dev/null
      }

      check_llauncher() {
        local repo="AugustLigh/LLauncher"
        local current latest asset_url response

        current="$(grep -oP '(?<=version = ")[^"]+' "$LLAUNCHER_NIX")"

        local auth_args=()
        [[ -n "''${GITHUB_TOKEN:-}" ]] && auth_args=(-H "Authorization: Bearer ''${GITHUB_TOKEN}")

        response="$(curl -sSL "''${auth_args[@]}" "https://api.github.com/repos/''${repo}/releases/latest")"
        latest="$(echo "$response" | jq -r '.tag_name // empty')"
        latest="''${latest#v}"

        if [[ -z "$latest" ]]; then
          log "llauncher: could not read latest release, skipping this run"
          return 0
        fi

        if [[ "$latest" == "$current" ]]; then
          log "llauncher: up to date ($current)"
          return 0
        fi

        asset_url="https://github.com/''${repo}/releases/download/''${latest}/LLauncher_''${latest}_amd64.AppImage"
        if ! curl -sSLo /dev/null -w '%{http_code}' "$asset_url" | grep -q '^200$'; then
          log "llauncher: new tag $latest found but expected asset missing, skipping"
          return 0
        fi

        log "llauncher: $current -> $latest, fetching hash..."
        local hash_b32 new_sha256
        hash_b32="$(nix-prefetch-url "$asset_url" 2>/dev/null)"
        new_sha256="$(nix hash convert --hash-algo sha256 --to sri "$hash_b32" 2>/dev/null \
          || nix-hash --to-base32 --type sha256 "$hash_b32")"

        if [[ -z "$new_sha256" ]]; then
          log "llauncher: failed to compute hash, skipping"
          return 0
        fi

        local tmp; tmp="$(mktemp)"
        sed \
          -e "s/version = \"''${current}\";/version = \"''${latest}\";/" \
          -e "s#sha256 = \"[^\"]*\";#sha256 = \"''${new_sha256}\";#" \
          "$LLAUNCHER_NIX" > "$tmp"
        mv "$tmp" "$LLAUNCHER_NIX"

        git_commit "$LLAUNCHER_NIX" "llauncher: $current -> $latest"
        notify "LLauncher update available" "$current → $latest. Run: nh os switch ~/nixos -u"
        log "llauncher: pinned $latest and committed"
      }

      check_hayase() {
        local current latest response

        current="$(grep -oP '(?<=version = ")[^"]+' "$HAYASE_NIX")"
        response="$(curl -sSL "https://api.hayase.watch/files/latest-linux.yml")"
        latest="$(echo "$response" | yq -r '.version // ""' 2>/dev/null)"

        if [[ -z "$latest" ]]; then
          log "hayase: could not read latest version, skipping this run"
          return 0
        fi

        if [[ "$latest" == "$current" ]]; then
          log "hayase: up to date ($current)"
          return 0
        fi

        local asset_url="https://api.hayase.watch/files/linux-hayase-''${latest}-linux.AppImage"
        log "hayase: $current -> $latest, fetching hash..."
        local hash_b32 new_hash
        hash_b32="$(nix-prefetch-url "$asset_url" 2>/dev/null)"
        new_hash="$(nix hash convert --hash-algo sha256 --to sri "$hash_b32" 2>/dev/null \
          || nix-hash --to-base32 --type sha256 "$hash_b32")"

        if [[ -z "$new_hash" ]]; then
          log "hayase: failed to compute hash, skipping"
          return 0
        fi

        local tmp; tmp="$(mktemp)"
        sed \
          -e "s/version = \"''${current}\";/version = \"''${latest}\";/" \
          -e "s#hash = \"[^\"]*\";#hash = \"''${new_hash}\";#" \
          "$HAYASE_NIX" > "$tmp"
        mv "$tmp" "$HAYASE_NIX"

        git_commit "$HAYASE_NIX" "hayase: $current -> $latest"
        notify "Hayase update available" "$current → $latest. Run: nh os switch ~/nixos -u"
        log "hayase: pinned $latest and committed"
      }

      check_llauncher
      check_hayase
    '';
  };
in
{
  systemd.user.services.pkg-update-check = {
    Unit.Description = "Check LLauncher and Hayase for new releases";
    Service = {
      Type = "oneshot";
      ExecStart = "${checkUpdates}/bin/check-updates";
    };
  };

  systemd.user.timers.pkg-update-check = {
    Unit.Description = "Timer for pkg-update-check";
    Timer = {
      OnCalendar = "*-*-* 09,18:00:00";
      Persistent = true;
      RandomizedDelaySec = "15m";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
