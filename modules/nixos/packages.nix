{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    jq
    iw
    rsync
    unzip
    unrar
    pavucontrol
    wlr-randr
    wl-clipboard
    cliphist
    dex
    resvg
    xdg-user-dirs
    ananicy-rules-cachyos_git
  ] ++ (with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    hermes-agent
    hermes-desktop
  ]);
}
