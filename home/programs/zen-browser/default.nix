{ inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
    ./extensions.nix
    ./policies.nix
    ./ublock.nix
    ./search.nix
    ./bookmarks.nix
    ./settings.nix
    ./spaces.nix
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.dark.id = 1;
  };
}
