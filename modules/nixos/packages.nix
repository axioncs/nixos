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
    sbctl
  ] ++ (with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    hermes-agent
    hermes-desktop
  ]);
  environment.variables = {
    PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
    PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
  };
}
