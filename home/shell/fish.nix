{ pkgs, lib, config, ... }:

{
  programs.fish = {
    enable = true;

    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
      { name = "done"; src = pkgs.fishPlugins.done.src; }
    ];

    interactiveShellInit = ''
      set -gx GPG_TTY (tty)
      if test -d "$HOME/.bun"
        set -gx BUN_INSTALL "$HOME/.bun"
        fish_add_path $BUN_INSTALL/bin
      end
      if test -d "$HOME/.opencode/bin"
        fish_add_path "$HOME/.opencode/bin"
      end

      set -U tide_left_prompt_items pwd git newline character
      set -U tide_right_prompt_items status cmd_duration background_jobs time
      set -U tide_cmd_duration_threshold 3000
      set -U tide_git_truncation_length 20

      set -U __done_min_cmd_duration 10000
      set -U __done_notification_urgency_level low

      set -x MANROFFOPT "-c"
      set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

      function fish_greeting
          fastfetch
      end

      function __history_previous_command
        switch (commandline -t)
        case "!"
          commandline -t $history[1]; commandline -f repaint
        case "*"
          commandline -i !
        end
      end
      function __history_previous_command_arguments
        switch (commandline -t)
        case "!"
          commandline -t ""
          commandline -f history-token-search-backward
        case "*"
          commandline -i '$'
        end
      end
      if [ "$fish_key_bindings" = fish_vi_key_bindings ]
        bind -Minsert ! __history_previous_command
        bind -Minsert '$' __history_previous_command_arguments
      else
        bind ! __history_previous_command
        bind '$' __history_previous_command_arguments
      end

      function history
          builtin history --show-time='%F %T ' $argv
      end
      function backup --argument filename
          cp $filename $filename.bak
      end
      function copy
          set count (count $argv | tr -d \n)
          if test "$count" = 2; and test -d "$argv[1]"
              set from (echo $argv[1] | trim-right /)
              set to (echo $argv[2])
              command cp -r $from $to
          else
              command cp $argv
          end
      end

      if status is-interactive
        command -v direnv &>/dev/null && direnv hook fish | source
        command -v zoxide &>/dev/null && zoxide init fish --cmd cd | source

        alias aria='hermes'
        alias bat="bat --style=plain"
        alias cat="bat --style=plain"

        alias ls='eza -al --color=always --group-directories-first --icons=always'
        alias la='eza -a --color=always --group-directories-first --icons=always'
        alias ll='eza -l --color=always --group-directories-first --icons=always'
        alias lt='eza -aT --color=always --group-directories-first --icons=always'
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
        abbr sn 'sudo nano'
        abbr s sudo
        abbr k pkill -9
        abbr yt yt-dlp

      end

      fish_add_path /home/axioncs/.spicetify
      fish_add_path ~/.local/bin
      set -x R_LIBS_USER ~/.local/lib/R/library
    '';
  };

  home.activation.removeManagedFishVariables = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    fish_vars="${config.home.homeDirectory}/.config/fish/fish_variables"
    if [ -L "$fish_vars" ] && readlink "$fish_vars" | grep -q '^/nix/store/'; then
      $DRY_RUN_CMD rm -f "$fish_vars"
    fi
  '';
}
