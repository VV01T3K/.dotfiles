{ config, pkgs, ... }:

{
  programs.plasma = {
    # power devil settings
    enable = true;
    spectacle = {
      shortcuts = {
        captureRectangularRegion = "Meta+Shift+S";
      };
    };
    desktop.mouseActions.middleClick = null;
    input = {
      mice = [
      {
        name = "Modern Mobile Mouse";
        vendorId = "045e";
        productId = "0827";
        enable = true;
        accelerationProfile = "none";
      }
      {
        name = "SteelSeries SteelSeries Rival 3";
        vendorId = "1038";
        productId = "184c";
        enable = true;
        accelerationProfile = "none";
      }
      ];
      touchpads = [{
        name = "ASUE1307:00 04F3:3279 Touchpad";
        productId = "3279";
        vendorId = "04f3";
        enable = true;
        disableWhileTyping = true;
        naturalScroll = true;
      }];
    };
    workspace = {
      # lookAndFeel = "Carl";
      cursor.theme = "Breeze";
      iconTheme = "kora";
      theme = "Carl";
      wallpaper = "/home/wojtek/.dotfiles/OWL_DESKTOP.png";
      windowDecorations = {
        library = "org.kde.kwin.aurorae";
        theme = "__aurorae__svg__WillowDarkBlur";
      };
    };
    kscreenlocker = {
      appearance.wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Elarun/contents/images/2560x1600.png";
    };
  };

  programs.konsole = {
    enable = true;
    profiles = {
        majn = {
        colorScheme = "WhiteOnBlack";
        };
    };
    defaultProfile = "majn";
    };
}