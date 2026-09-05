{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];
  programs.nixcord = {
    enable = true;
    discord.equicord.enable = true;
    config.plugins = {
      alwaysAnimate.enable = true;
      anonymiseFileNames.enable = true;
      betterFolders.enable = true;
      betterGifPicker.enable = true;
      betterSettings.enable = true;
      clearUrls.enable = true;
      commandPalette = {
        hotkey = [ ];
      };
      copyEmojiMarkdown.enable = true;
      crashHandler.enable = true;
      customTimestamps = {
        formats = {
          enable = false;
        };
      };
      experiments.enable = true;
      fixSpotifyEmbeds.enable = true;
      imageZoom.enable = true;
      messageLogger.enable = true;
      moreUserTags = {
        tagSettings = {
          administrator = {
            enable = false;
          };
          chatModerator = {
            enable = false;
          };
          moderator = {
            enable = false;
          };
          moderatorStaff = {
            enable = false;
          };
          owner = {
            enable = false;
          };
          voiceModerator = {
            enable = false;
          };
          webhook = {
            enable = false;
          };
          enable = false;
        };
      };
      noTrack.enable = true;
      permissionsViewer.enable = true;
      questify = {
        enable = true;
        acknowledgedNotices = {
          quest-ban-warning-2026-08-07 = true;
          quest-ban-warning-2026-08-26 = true;
        };
        allowChangingDangerousSettings = true;
        autoCompleteQuestTypes = {
          PLAY_ON_DESKTOP = true;
          PLAY_ON_XBOX = true;
          PLAY_ON_PLAYSTATION = true;
          PLAY_ACTIVITY = true;
          WATCH_VIDEO = true;
          WATCH_VIDEO_ON_MOBILE = true;
          ACHIEVEMENT_IN_ACTIVITY = true;
        };
        questButtonBadgeCount = 9;
      };
      quickReply.enable = true;
      randomVoice = {
        keybind = [ ];
      };
      readAllNotificationsButton.enable = true;
      showHiddenChannels.enable = true;
      translate.enable = true;
      vcNarrator = {
        voice = null;
      };
    };
    extraConfig.plugins = {
      musicRichPresence = {
        showLastFmLogo = true;
      };
    };
  };
}
