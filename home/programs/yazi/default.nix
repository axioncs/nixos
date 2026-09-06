{ pkgs, lib, ... }:

let
  pref-by-location-src = pkgs.fetchFromGitHub {
    owner = "boydaihungst";
    repo = "pref-by-location.yazi";
    rev = "0248cfe9737fccfdc11bac485f7a19c440e53e46";
    hash = "sha256-POC/a1DfOsYCctI43611wCqsFxGNu11tfcdFj+Nlx5E=";
  };
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      mgr = {
        ratio = [ 1 4 3 ];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "size";
        show_hidden = true;
        show_symlink = true;
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        tab_size = 1;
        max_width = 1200;
        max_height = 1800;
        ueberzug_scale = 1;
        ueberzug_offset = [ 0 0 0 0 ];
      };

      tasks = {
        micro_workers = 10;
        macro_workers = 25;
        bizarre_retry = 5;
      };
    };

    plugins = with pkgs.yaziPlugins; {
      full-border = full-border;
      git = git;
      smart-filter = smart-filter;
      smart-enter = smart-enter;
      chmod = chmod;
      pref-by-location = pref-by-location-src;
    };

    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
      require("pref-by-location"):setup({})
    '';

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "e" "z" ];
          run = "shell 'zeditor \"$PWD\" &'";
          desc = "Open current directory in Zed";
        }
        {
          on = [ "e" "t" ];
          run = "shell 'kitty --directory \"$PWD\" &'";
          desc = "Open current directory in Kitty";
        }
        {
          on = [ "l" ];
          run = "plugin smart-enter";
          desc = "Enter directory or open file (smart-enter)";
        }
        {
          on = [ "f" ];
          run = "plugin smart-filter";
          desc = "Smart filter";
        }
        {
          on = [ "c" "m" ];
          run = "plugin chmod";
          desc = "Chmod selected files";
        }
        {
          on = [ "." ];
          run = [ "hidden toggle" "plugin pref-by-location -- save" ];
          desc = "Toggle hidden files";
        }
        {
          on = [ "m" "s" ];
          run = [ "linemode size" "plugin pref-by-location -- save" ];
          desc = "Linemode: size";
        }
        {
          on = [ "m" "p" ];
          run = [ "linemode permissions" "plugin pref-by-location -- save" ];
          desc = "Linemode: permissions";
        }
        {
          on = [ "m" "b" ];
          run = [ "linemode btime" "plugin pref-by-location -- save" ];
          desc = "Linemode: btime";
        }
        {
          on = [ "m" "m" ];
          run = [ "linemode mtime" "plugin pref-by-location -- save" ];
          desc = "Linemode: mtime";
        }
        {
          on = [ "m" "o" ];
          run = [ "linemode owner" "plugin pref-by-location -- save" ];
          desc = "Linemode: owner";
        }
        {
          on = [ "m" "n" ];
          run = [ "linemode none" "plugin pref-by-location -- save" ];
          desc = "Linemode: none";
        }
        {
          on = [ "," "t" ];
          run = "plugin pref-by-location -- toggle";
          desc = "Toggle auto-save preferences";
        }
        {
          on = [ "," "d" ];
          run = "plugin pref-by-location -- disable";
          desc = "Disable auto-save preferences";
        }
        {
          on = [ "," "R" ];
          run = "plugin pref-by-location -- reset";
          desc = "Reset preference of cwd";
        }
        {
          on = [ "," "m" ];
          run = [ "sort mtime --reverse=no" "linemode mtime" "plugin pref-by-location -- save" ];
          desc = "Sort by modified time";
        }
        {
          on = [ "," "M" ];
          run = [ "sort mtime --reverse" "linemode mtime" "plugin pref-by-location -- save" ];
          desc = "Sort by modified time (reverse)";
        }
        {
          on = [ "," "b" ];
          run = [ "sort btime --reverse=no" "linemode btime" "plugin pref-by-location -- save" ];
          desc = "Sort by birth time";
        }
        {
          on = [ "," "B" ];
          run = [ "sort btime --reverse" "linemode btime" "plugin pref-by-location -- save" ];
          desc = "Sort by birth time (reverse)";
        }
        {
          on = [ "," "e" ];
          run = [ "sort extension --reverse=no" "plugin pref-by-location -- save" ];
          desc = "Sort by extension";
        }
        {
          on = [ "," "E" ];
          run = [ "sort extension --reverse" "plugin pref-by-location -- save" ];
          desc = "Sort by extension (reverse)";
        }
        {
          on = [ "," "a" ];
          run = [ "sort alphabetical --reverse=no" "plugin pref-by-location -- save" ];
          desc = "Sort alphabetically";
        }
        {
          on = [ "," "A" ];
          run = [ "sort alphabetical --reverse" "plugin pref-by-location -- save" ];
          desc = "Sort alphabetically (reverse)";
        }
        {
          on = [ "," "n" ];
          run = [ "sort natural --reverse=no" "plugin pref-by-location -- save" ];
          desc = "Sort naturally";
        }
        {
          on = [ "," "N" ];
          run = [ "sort natural --reverse" "plugin pref-by-location -- save" ];
          desc = "Sort naturally (reverse)";
        }
        {
          on = [ "," "s" ];
          run = [ "sort size --reverse=no" "linemode size" "plugin pref-by-location -- save" ];
          desc = "Sort by size";
        }
        {
          on = [ "," "S" ];
          run = [ "sort size --reverse" "linemode size" "plugin pref-by-location -- save" ];
          desc = "Sort by size (reverse)";
        }
        {
          on = [ "," "r" ];
          run = [ "sort random --reverse=no" "plugin pref-by-location -- save" ];
          desc = "Sort randomly";
        }
      ];
    };
  };
}
