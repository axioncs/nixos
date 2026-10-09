{ ... }:

{
  programs.zen-browser.profiles.default.bookmarks = {
    force = true;

    settings = [
      {
        name = "Socials";

        bookmarks = [
          {
            name = "YouTube";
            url = "https://www.youtube.com/";
          }
          {
            name = "Facebook";
            url = "https://www.facebook.com/";
          }
          {
            name = "X";
            url = "https://x.com/";
          }
          {
            name = "Reddit";
            url = "https://www.reddit.com/";
          }
          {
            name = "4chan";
            url = "https://4chan.org/";
          }
          {
            name = "Pinterest";
            url = "https://www.pinterest.com/";
          }
        ];
      }

      {
        name = "Study";

        bookmarks = [
          {
            name = "Mathematics";

            bookmarks = [
              {
                name = "3Blue1Brown";
                url = "https://www.3blue1brown.com/";
              }
              {
                name = "MIT 18.01SC — Single Variable Calculus";
                url =
                  "https://ocw.mit.edu/courses/18-01sc-single-variable-calculus-fall-2010/";
              }
              {
                name = "MIT 18.06SC — Linear Algebra";
                url =
                  "https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/";
              }
              {
                name = "MIT 6.1200J — Mathematics for Computer Science";
                url =
                  "https://ocw.mit.edu/courses/6-1200j-mathematics-for-computer-science-spring-2024/";
              }
              {
                name = "MIT OpenCourseWare";
                url = "https://ocw.mit.edu/";
              }
              {
                name = "Harvard Stat 110";
                url = "https://stat110.hsites.harvard.edu/";
              }
              {
                name = "Steve Brunton — Probability Bootcamp";
                url = "https://www.youtube.com/@SteveBrunton";
              }
            ];
          }

          {
            name = "Data Science";

            bookmarks = [
              {
                name = "Kaggle";
                url = "https://www.kaggle.com/";
              }
              {
                name = "UCI Machine Learning Repository";
                url = "https://archive.ics.uci.edu/";
              }
              {
                name = "Python Documentation";
                url = "https://docs.python.org/3/";
              }
              {
                name = "NumPy Documentation";
                url = "https://numpy.org/doc/";
              }
              {
                name = "pandas Documentation";
                url = "https://pandas.pydata.org/docs/";
              }
              {
                name = "scikit-learn Documentation";
                url = "https://scikit-learn.org/stable/";
              }
            ];
          }

          {
            name = "Cognitive Science";

            bookmarks = [
              {
                name = "OpenStax Psychology";
                url = "https://openstax.org/books/psychology-2e/";
              }
              {
                name = "Noba Psychology";
                url = "https://nobaproject.com/";
              }
              {
                name = "Cognitive Science Society";
                url = "https://cognitivesciencesociety.org/";
              }
              {
                name = "Stanford Encyclopedia — Cognitive Science";
                url = "https://plato.stanford.edu/entries/cognitive-science/";
              }
            ];
          }

          {
            name = "Research";

            bookmarks = [
              {
                name = "ResearchGate";
                url = "https://www.researchgate.net/";
              }
              {
                name = "Google Scholar";
                url = "https://scholar.google.com/";
              }
              {
                name = "Semantic Scholar";
                url = "https://www.semanticscholar.org/";
              }
              {
                name = "arXiv";
                url = "https://arxiv.org/";
              }
              {
                name = "OpenAlex";
                url = "https://openalex.org/";
              }
              {
                name = "Connected Papers";
                url = "https://www.connectedpapers.com/";
              }
              {
                name = "Crossref Search";
                url = "https://search.crossref.org/";
              }
              {
                name = "Zotero";
                url = "https://www.zotero.org/";
              }
            ];
          }

          {
            name = "BSc SDS Study Guide";
            url =
              "file:///home/axioncs/Study%20Materials/BSc_SDS_Study_Guide.html";
          }
        ];
      }

      {
        name = "Tech";

        bookmarks = [
          {
            name = "Nix";

            bookmarks = [
              {
                name = "NixOS Packages";
                url = "https://search.nixos.org/packages";
              }
              {
                name = "NixOS Options";
                url = "https://search.nixos.org/options";
              }
              {
                name = "MyNixOS";
                url = "https://mynixos.com/";
              }
              {
                name = "Home Manager Options";
                url = "https://home-manager-options.extranix.com/";
              }
              {
                name = "NixOS Wiki";
                url = "https://wiki.nixos.org/";
              }
              {
                name = "NixOS Manual";
                url = "https://nixos.org/manual/nixos/stable/";
              }
              {
                name = "Nixpkgs Manual";
                url = "https://nixos.org/manual/nixpkgs/stable/";
              }
              {
                name = "Nix Manual";
                url = "https://nix.dev/manual/nix/latest/";
              }
              {
                name = "Home Manager Manual";
                url = "https://home-manager.dev/manual/";
              }
              {
                name = "Noogle";
                url = "https://noogle.dev/";
              }
            ];
          }

          {
            name = "Linux";

            bookmarks = [
              {
                name = "ArchWiki";
                url = "https://wiki.archlinux.org/";
              }
              {
                name = "Linux Kernel";
                url = "https://www.kernel.org/";
              }
              {
                name = "systemd Documentation";
                url = "https://www.freedesktop.org/software/systemd/";
              }
              {
                name = "Freedesktop";
                url = "https://www.freedesktop.org/";
              }
            ];
          }

          {
            name = "Wayland / Desktop";

            bookmarks = [
              {
                name = "Hyprland";
                url = "https://wiki.hypr.land/";
              }
              {
                name = "Noctalia";
                url = "https://docs.noctalia.dev/";
              }
            ];
          }

          {
            name = "Development";

            bookmarks = [
              {
                name = "MDN Web Docs";
                url = "https://developer.mozilla.org/";
              }
              {
                name = "Stack Overflow";
                url = "https://stackoverflow.com/";
              }
              {
                name = "DevDocs";
                url = "https://devdocs.io/";
              }
            ];
          }

          {
            name = "Nothing Archive";
            url = "https://github.com/spike0en/nothing_archive";
          }
        ];
      }

      {
        name = "Anime / Gacha";

        bookmarks = [
          {
            name = "KeqingMains";
            url = "https://keqingmains.com/";
          }
          {
            name = "Genshin Impact Wiki";
            url = "https://genshin-impact.fandom.com/wiki/";
          }
          {
            name = "Wotaku";
            url = "https://wotaku.wiki/";
          }
          {
            name = "Danbooru";
            url = "https://danbooru.donmai.us/";
          }
          {
            name = "Pixiv";
            url = "https://www.pixiv.net/";
          }
        ];
      }

      {
        name = "Gaming";

        bookmarks = [
          {
            name = "Gaming Route";
            url = "file:///home/axioncs/Downloads/gaming-route.html";
          }
          {
            name = "SteamGridDB";
            url = "https://www.steamgriddb.com/";
          }

          {
            name = "Game Resources";

            bookmarks = [
              {
                name = "FMHY";
                url = "https://fmhy.net/";
              }
              {
                name = "Pirated Games Mega Thread";
                url = "https://rentry.org/pgames";
              }
            ];
          }
        ];
      }

      {
        name = "Torrenting";

        bookmarks = [
          {
            name = "TorrentBD";
            url = "https://www.torrentbd.net/";
          }
          {
            name = "RuTracker";
            url = "https://rutracker.org/forum/index.php";
          }
        ];
      }

      {
        name = "Movies & TV";

        bookmarks = [
          {
            name = "JustWatch";
            url = "https://www.justwatch.com/";
          }
          {
            name = "TMDB";
            url = "https://www.themoviedb.org/";
          }
          {
            name = "FilmGrab";
            url = "https://film-grab.com/";
          }

          {
            name = "Movie Sources";

            bookmarks = [
              {
                name = "OlaMovies";
                url = "https://olamovies.dad/";
              }
              {
                name = "Pahe";
                url = "https://pahe.ink/";
              }
              {
                name = "PSArips";
                url = "https://psa.wf/";
              }
              {
                name = "MCUBD";
                url = "http://www.mcubd.top/";
              }
              {
                name = "MLWBD";
                url = "https://mlwbd.is/";
              }
              {
                name = "MLSBD";
                url = "https://mlsbd.shop/";
              }
            ];
          }
        ];
      }
      {
        name = "Music";

        bookmarks = [
          {
            name = "Last.fm";
            url = "https://www.last.fm/";
          }
          {
            name = "Rate Your Music";
            url = "https://rateyourmusic.com/";
          }
          {
            name = "MusicBrainz";
            url = "https://musicbrainz.org/";
          }
          {
            name = "Bandcamp";
            url = "https://bandcamp.com/";
          }
          {
            name = "Genius";
            url = "https://genius.com/";
          }

          {
            name = "Audio Gear";

            bookmarks = [
              {
                name = "Crinacle Graph Tool";
                url = "https://graph.hangout.audio/";
              }
              {
                name = "Squiglink";
                url = "https://squig.link/";
              }
              {
                name = "AutoEq";
                url = "https://autoeq.app/";
              }
              {
                name = "Audio Science Review";
                url = "https://www.audiosciencereview.com/";
              }
              {
                name = "RTINGS Headphones";
                url = "https://www.rtings.com/headphones";
              }
              {
                name = "Head-Fi";
                url = "https://www.head-fi.org/";
              }
            ];
          }
        ];
      }
    ];
  };
}
