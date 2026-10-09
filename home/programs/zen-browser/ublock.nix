{ lib, ... }:

let
  id = "uBlock0@raymondhill.net";
  nl = lib.concatStringsSep "\n";

  lists = [
    # built-in
    "user-filters" "ublock-filters" "ublock-badware" "ublock-privacy"
    "ublock-quick-fixes" "ublock-unbreak"
    "easylist" "adguard-mobile"
    "easyprivacy" "adguard-spyware-url" "block-lan"
    "urlhaus-1" "plowe-0" "dpollock-0"
    "easylist-cookies" "fanboy-social"
    "easylist-chat" "easylist-newsletters" "easylist-notifications"
    "easylist-annoyances" "ublock-annoyances"
    # imported
    "https://gitlab.com/DandelionSprout/adfilt/-/raw/master/LegitimateURLShortener.txt"
    "https://raw.githubusercontent.com/yokoffing/filterlists/main/block_third_party_fonts.txt"
    "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
    "https://gitlab.com/DandelionSprout/adfilt/-/raw/master/Dandelion%20Sprout's%20Anti-Malware%20List.txt"
    "https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/dyndns.txt"
    "https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/tif.mini.txt"
    "https://raw.githubusercontent.com/fmhy/FMHYFilterlist/main/filterlist-basic.txt"
    "https://gitlab.com/hagezi/mirror/-/raw/main/dns-blocklists/adblock/ultimate.mini.txt"
  ];

  filters = [
    "||doubleclick.net^$important"
    "||google-analytics.com^$important"
    "||gravatar.com^$important,third-party"
    "www.reddit.com###redesign-beta-optin-btn"
    "old.reddit.com###redesign-beta-optin-btn"
  ];
in
{
  programs.zen-browser.policies."3rdparty".Extensions.${id} = {
    toOverwrite = {
      filterLists = lists;
      inherit filters;
    };

    adminSettings = builtins.toJSON {
      userSettings = {
        prefetchingDisabled = true;
        hyperlinkAuditingDisabled = true;
        cnameUncloakEnabled = true;
        advancedUserEnabled = true;
        suspendUntilListsAreLoaded = true;
        parseAllABPHideFilters = true;
        ignoreGenericCosmeticFilters = false;
        autoUpdate = true;
      };
      hostnameSwitchesString = "no-csp-reports: * true";
      hiddenSettingsString = nl [
        "autoCommentFilterTemplate {{url}}"
        "autoUpdateDelayAfterLaunch 10"
        "filterAuthorMode true"
        "trustedListPrefixes -"
        "updateAssetBypassBrowserCache true"
      ];
    };
  };
}
