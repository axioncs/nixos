{ ... }:

{
  programs.zen-browser.profiles.default.search = {
    force = true;
    default = "google";

    engines = {
      google.metaData.alias = "@g";

      kagi = {
        name = "Kagi";
        urls = [{
          template = "https://kagi.com/search?q={searchTerms}";
        }];
        definedAliases = [ "@k" ];
      };

      brave = {
        name = "Brave Search";
        urls = [{
          template = "https://search.brave.com/search?q={searchTerms}";
        }];
        definedAliases = [ "@br" ];
      };

      wikipedia = {
        name = "Wikipedia";
        urls = [{
          template =
            "https://en.wikipedia.org/w/index.php?search={searchTerms}";
        }];
        definedAliases = [ "@w" ];
      };

      scholar = {
        name = "Google Scholar";
        urls = [{
          template =
            "https://scholar.google.com/scholar?q={searchTerms}";
        }];
        definedAliases = [ "@sch" ];
      };

      youtube = {
        name = "YouTube";
        urls = [{
          template =
            "https://www.youtube.com/results?search_query={searchTerms}";
        }];
        definedAliases = [ "@yt" ];
      };

      github = {
        name = "GitHub";
        urls = [{
          template = "https://github.com/search?q={searchTerms}";
        }];
        definedAliases = [ "@gh" ];
      };

      rutracker = {
        name = "RuTracker";
        urls = [{
          template =
            "https://rutracker.org/forum/tracker.php?nm={searchTerms}";
        }];
        definedAliases = [ "@rt" ];
      };
    };
  };
}
