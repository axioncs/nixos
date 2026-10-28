# nixos

Axion's NixOS flake config (Hyprland desktop, home-manager, agenix, lanzaboote).

![screenshot](./assets/screenshot.png)

## Install

1. Boot a NixOS installer, partition your disks, mount at `/mnt`.

2. Clone the config directly into the target system:
   ```sh
   git clone https://github.com/axioncs/nixos /mnt/home/<your-username>/nixos
   cd /mnt/home/<your-username>/nixos
   ```

3. Regenerate hardware config for this machine:
   ```sh
   sudo nixos-generate-config --root /mnt
   cp /mnt/etc/nixos/hardware-configuration.nix modules/nixos/filesystems.nix
   ```

4. Edit `modules/axioncs/settings.nix` with your own values:
   ```nix
   username     = "axioncs";   # -> your username
   hostname     = "nixos";     # -> your hostname
   stateVersion = "26.05";     # -> leave matching your install ISO's version
   desktop      = "hyprland";  # -> hyprland | umbriel | mango | sway | labwc
   ```

5. Handle machine-specific dependencies (skip any that don't apply):
   - `secrets/*.age` are encrypted to the author's keys and won't decrypt for you. Either replace them with your own (see [Secrets](#secrets-agenix)), or remove `modules/nixos/agenix.nix` and its consumers: the `netrc-file`/`extraOptions` lines in `modules/nixos/nix.nix`, the rpc-secret in `home/programs/aria2.nix`, `steamGridDbKeyFile` in `home/programs/faugus-launcher/default.nix`, and `environmentFile` in `modules/nixos/navidrome.nix`.
   - `modules/nixos/boot.nix` uses `linuxPackages_cachyos-lto-znver4` (ThinLTO, built for Zen 4 only; it won't run on other CPUs) and AMD-specific kernel params (`amd_pstate=active`). Swap to `linuxPackages_cachyos` or a stock kernel if you're not on Zen 4.
   - `modules/nixos/boot.nix` also enables lanzaboote (Secure Boot) and force-disables systemd-boot. Keys must exist before install, see step 6. To skip Secure Boot, drop the `boot.lanzaboote` block and the `systemd-boot` mkForce.
   - `modules/nixos/desktop.nix` enables `chaotic.mesa-git` (bleeding-edge Mesa from nyx). Remove it if you want stable Mesa.

6. Put keys in the target system before installing:
   ```sh
   # Secure Boot keys (lanzaboote signs the boot entries during install)
   nix shell nixpkgs#sbctl -c sbctl create-keys
   sudo cp -a /var/lib/sbctl /mnt/var/lib/sbctl

   # agenix machine key (root-only, decrypts secrets at boot)
   sudo install -d -m700 /mnt/var/lib/agenix
   sudo ssh-keygen -t ed25519 -N "" -C agenix -f /mnt/var/lib/agenix/id_ed25519
   ```
   Either restore your original machine key from backup, or generate a new one and re-create the secrets for it (see [Secrets](#secrets-agenix)).

7. Install:
   ```sh
   sudo nixos-install --flake .#nixos
   ```

8. Give ownership of the flakes directory to your user:
   ```sh
   sudo chown -R <your-username>:users /mnt/home/<your-username>/nixos
   ```

9. Reboot, log in, restore your personal age key to `~/.config/age/keys.txt` (see [Secrets](#secrets-agenix)), then apply home-manager (should happen automatically as part of the system activation via the flake, but to re-apply manually):
   ```sh
   nh os switch ~/nixos
   ```

10. Enroll the Secure Boot keys, see [Secure Boot](#secure-boot-lanzaboote).

11. Once you're on the desktop, run `hyprctl monitors` and update the hardcoded monitor names/resolutions/scale in `desktops/hyprland/cfg/display.lua` (`eDP-1`, `HDMI-A-1`, etc) to match your actual outputs.

## Rebuilding after changes

```sh
nh os switch ~/nixos
```

Edit config files with `hx` (Helix). Flakes ignore untracked files, so `git add` new files before rebuilding.

## Music (Navidrome + Feishin)

Soulseek downloads (Nicotine+) land in `~/Music`. Navidrome (`modules/nixos/navidrome.nix`) indexes that folder and serves it on `127.0.0.1:4533`; Feishin is the client and plays through mpv.

- The service runs as the main user, with `ProtectHome` relaxed to `read-only`, so it can read `~/Music`.
- Keep Nicotine+'s incomplete-downloads directory outside `~/Music` so only finished files get indexed.
- First run: open `http://127.0.0.1:4533`, create the admin user, then add the server in Feishin (type Navidrome, same URL).
- In Feishin, set Settings → Playback → Audio Player to **MPV**.
- Last.fm: Navidrome does the scrobbling. Enable it under Personal in the web UI, and enable Scrobble in Feishin's playback settings. The API key and secret live in the `navidrome-env` secret.

## Secrets (agenix)

Encrypted secrets live in `secrets/*.age` and decrypt at activation to `/run/agenix/`. Every secret is encrypted to two recipients, listed in `secrets/agenix-rules.nix`. Declarations are in `modules/nixos/agenix.nix`.

| Key | Location | Purpose |
|---|---|---|
| machine | `/var/lib/agenix/id_ed25519` (root-only) | Decrypts at boot. Must be on the root filesystem, `/home` isn't mounted during activation. |
| personal | `~/.config/age/keys.txt` | Editing, re-encrypting, recovery. |

Never commit either private key. **Back both up offline.**

| Secret | Used by |
|---|---|
| `nix-netrc` | `modules/nixos/nix.nix` (`netrc-file`) |
| `nix-github-token` | `modules/nixos/nix.nix` (`!include`, GitHub `access-tokens`) |
| `aria2-rpc` | `home/programs/aria2.nix` (config is generated at service start) |
| `steamgriddb` | `home/programs/faugus-launcher/` (merged into `config.json` on activation) |
| `navidrome-env` | `modules/nixos/navidrome.nix` (`environmentFile`, `ND_LASTFM_*` variables) |

Create, edit or rotate a secret (opens `$EDITOR`):

```fish
cd ~/nixos/secrets
agenix -i ~/.config/age/keys.txt -e <name>.age
git add -A; nh os switch ~/nixos
```

New secrets also need an entry in `secrets/agenix-rules.nix` and in `age.secrets` in `modules/nixos/agenix.nix`.

After changing recipients in `secrets/agenix-rules.nix`, re-encrypt everything:

```fish
agenix -i ~/.config/age/keys.txt -r
```

Check a secret decrypts:

```fish
nix shell nixpkgs#age -c age -d -i ~/.config/age/keys.txt <name>.age | wc -c
```

Setting up your own keys: generate the personal key with `nix shell nixpkgs#age -c age-keygen -o ~/.config/age/keys.txt`, put its public key (`age-keygen -y`) and the machine public key (`/var/lib/agenix/id_ed25519.pub`) into `secrets/agenix-rules.nix`, delete the old `*.age`, and create each secret with `agenix -e`.

Intentionally outside agenix: Hermes API keys (`~/.hermes/.env`) and Surfshark credentials.

## Secure Boot (lanzaboote)

`modules/nixos/boot.nix` uses [lanzaboote](https://github.com/nix-community/lanzaboote) with keys in `/var/lib/sbctl` (**back up this directory**; losing it means re-enrolling).

After the first boot with lanzaboote:

1. Check everything is signed:
   ```sh
   sudo sbctl verify
   ```
2. In firmware setup, put Secure Boot into **Setup Mode** (clear/delete the platform keys; wording varies by vendor).
3. Enroll your keys (`--microsoft` keeps Microsoft's, needed for some option ROMs and dual-boot):
   ```sh
   sudo sbctl enroll-keys --microsoft
   ```
4. Reboot, make sure Secure Boot is enabled in firmware, then confirm:
   ```sh
   bootctl status | rg 'Secure Boot'
   ```

On an existing systemd-boot install, run `sudo sbctl create-keys` first, rebuild, then continue from step 1.

## Credits

Built on top of / pulls from:
- [noctalia-dev/noctalia](https://github.com/noctalia-dev/noctalia)
- [numtide/llm-agents.nix](https://github.com/numtide/llm-agents.nix)
- [OpalAayan/snappy-switcher](https://github.com/OpalAayan/snappy-switcher)
- [chaotic-cx/nyx](https://github.com/chaotic-cx/nyx) (CachyOS kernel, mesa-git)
- [Gerg-L/spicetify-nix](https://github.com/Gerg-L/spicetify-nix)
- [0xc000022070/zen-browser-flake](https://github.com/0xc000022070/zen-browser-flake)
- [nix-community/home-manager](https://github.com/nix-community/home-manager)
- [nix-community/lanzaboote](https://github.com/nix-community/lanzaboote)
- [ryantm/agenix](https://github.com/ryantm/agenix)

## License

MIT — see [LICENSE](LICENSE).
