{ ... }:

{
  programs.zen-browser.policies = {
    DisableAppUpdate = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    DisableFirefoxAccounts = true;
    DisablePocket = true;

    "3rdparty".Extensions."uBlock0@raymondhill.net".toOverwrite.filterLists = [
      "ublock-filters"
      "ublock-badware"
      "ublock-privacy"
      "ublock-unbreak"
      "ublock-quick-fixes"
    ];
  };
}
