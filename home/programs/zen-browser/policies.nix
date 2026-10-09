{ ... }:

{
  programs.zen-browser.policies = {
    DisableAppUpdate = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    DisableFirefoxAccounts = true;
    DisablePocket = true;
  };
}
