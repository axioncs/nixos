{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;

    settings = {
      format = "$username$hostname$directory$fill[$all](grey)$time$line_break$character";

      character = {
        success_symbol = "[~>](bold green)";
        error_symbol = "[~>](bold red)";
      };

      fill = {
        symbol = "─";
        style = "#222222";
      };

      cmd_duration = {
        min_time = 10000;
      };

      time = {
        disabled = false;
        time_format = "%F %T";
        style = "#444444";
        format = "[$time]($style)";
      };

      python = {
        symbol = "py ";
      };

      package = {
        symbol = "package ";
        style = "#777777";
      };

      git_branch = {
        symbol = "git ";
      };

      aws = {
        symbol = "aws ";
      };

      terraform = {
        symbol = "tf ";
        style = "bold #777777";
      };
    };
  };

  # Paths and variables are rebuilt every session (no universal variables).
  home.sessionVariables.BUN_INSTALL = "$HOME/.bun";
  home.sessionPath = [
    "$HOME/.bun/bin"
    "$HOME/.opencode/bin"
  ];

  programs.fish = {
    enable = true;

    plugins = [
      { name = "puffer"; src = pkgs.fishPlugins.puffer.src; }
    ];

    functions = {
      fish_greeting = "fastfetch";

      history = ''
        if contains -- "$argv[1]" delete clear clear-session merge save
            builtin history $argv
        else
            builtin history --show-time='%F %T ' $argv
        end
      '';

      backup = ''
        for f in $argv
            set -l src (string trim -r -c / -- $f)
            command cp -a -- $src $src.bak-(date +%F-%H%M%S)
        end
      '';

      dumpdir = ''
        set -q argv[1]; or set argv .
        rg --heading --no-line-number --sort path --hidden -g '!.git' "" $argv
      '';

      __cpmv_rs = ''
        set -l mode $argv[1]
        set -l args $argv[2..-1]

        if test (count $args) -lt 2
            echo "usage: SRC... DEST"
            return 1
        end

        set -l dest $args[-1]
        set -l srcs (string trim -r -c / -- $args[1..-2])
        set -l dest_is_dir 0
        test -d "$dest"; and set dest_is_dir 1

        for s in $srcs
            if test $dest_is_dir = 1
                set target $dest/(path basename -- $s)
            else
                set target $dest
            end
            if test -e "$target"; or test -L "$target"
                set -l n 1
                while test -e "$target.~$n~"; or test -L "$target.~$n~"
                    set n (math $n + 1)
                end
                command mv -- "$target" "$target.~$n~"
                echo "renamed existing: $target -> $target.~$n~"
            end
        end

        set -l flags -ah --info=progress2 --partial
        test $mode = mv; and set flags $flags --remove-source-files

        if test (count $srcs) = 1; and test -d "$srcs[1]"; and test $dest_is_dir = 0
            rsync $flags -- "$srcs[1]/" "$dest/"
        else
            rsync $flags -- $srcs $dest
        end
        or return $status

        if test $mode = mv
            for s in $srcs
                test -d "$s"; and find "$s" -depth -type d -empty -delete
            end
        end
      '';

      cpr = "__cpmv_rs cp $argv";
      mvr = "__cpmv_rs mv $argv";
    };

    interactiveShellInit = ''
      set -x MANROFFOPT "-c"
      set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

      if status is-interactive
        command -v direnv &>/dev/null && direnv hook fish | source
        command -v zoxide &>/dev/null && zoxide init fish | source
        command -v zoxide &>/dev/null && zoxide init fish --cmd cd | source

        alias aria='hermes'
        alias bat="bat --style=plain"
        alias cat="bat --style=plain"

        alias ls='eza -al --color=auto --group-directories-first --icons=auto'
        alias la='eza -a --color=auto --group-directories-first --icons=auto'
        alias ll='eza -l --color=auto --group-directories-first --icons=auto'
        alias lt='eza -aT --color=auto --group-directories-first --icons=auto'
        alias l.="eza -a | grep -e '^\.'"

        abbr lg lazygit
        abbr gd 'git diff'
        abbr ga 'git add .'
        abbr gc 'git commit -am'
        abbr gl 'git log'
        abbr gs 'git status'
        abbr gst 'git stash'
        abbr gsp 'git stash pop'
        abbr gp 'git push'
        abbr gpl 'git pull'
        abbr gsw 'git switch'
        abbr gsm 'git switch main'
        abbr gb 'git branch'
        abbr gbd 'git branch -d'
        abbr gco 'git checkout'
        abbr gsh 'git show'
        abbr l ls
        abbr r reboot
        abbr se sudoedit
        abbr s sudo
        abbr k pkill -9
        abbr yt yt-dlp
        abbr u 'nh os switch ~/nixos -u'
        abbr cb 'wl-copy'
      end
    '';
  };
}
