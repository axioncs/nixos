{ lib, ... }:

{
  programs.zen-browser.profiles = lib.genAttrs [ "default" "dark" ] (_: {
    settings = {
      "browser.theme.content-theme" = 2;
      "extensions.autoDisableScopes" = 0;
      "browser.tabs.insertAfterCurrent" = true;
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "zen.ctrlTab.show-pending-tabs" = true;
      "zen.workspaces.continue-where-left-off" = true;
      "zen.view.compact.hide-tabbar" = true;
      "zen.urlbar.behavior" = "float";
      "zen.welcome-screen.seen" = true;
    };
  });
}
