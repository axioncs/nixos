{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    jq
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
  ] ++ (with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    hermes-agent
    hermes-desktop
  ]);
}
