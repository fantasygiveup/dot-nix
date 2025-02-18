{ pkgs, lib, ... }:
with lib.gvariant; {
  # To see changes using gnome-tweaks (or any other method) use `dconf watch /` command.
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        text-scaling-factor = 1.25;
        font-name = "Ubuntu Medium 11";
        document-font-name = "Ubuntu Regular 11";
        monospace-font-name = "JetBrainsMono Nerd Font Mono 11";
        font-antialiasing = "rgba";
        font-hinting = "slight";
        clock-show-weekday = true;
        enable-hot-corners = false; # disable top-left hot corner.
      };
      "org/gnome/desktop/input-sources" = {
        sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "ua" ]) ];
        xkb-options =
          [ "terminate:ctrl_alt_bksp" "caps:ctrl_modifier" ]; # use caps as ctrl
      };
      "org/gnome/desktop/wm/keybindings" = { show-desktop = [ "<Super>d" ]; };
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = (lib.gvariant.mkUint32 3700);
      };

      "org/gnome/shell" = {
        enabled-extensions = [ "dash-to-dock@micxgx.gmail.com" ];
        last-selected-power-profile = "performance";
      };
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-timeout = 900; # 15min
        sleep-inactive-ac-type = "suspend";
      };
      "org/gnome/desktop/session" = {
        idle-delay = (lib.gvariant.mkUint32 300); # 5min
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        apply-custom-theme = false;
        dock-position = "BOTTOM";
        transparency-mode = "FIXED";
        background-opacity = 1.0;
        height-fraction = 1.0;
        dash-max-icon-size = 36;
        extend-height = true;
        show-apps-always-in-the-edge = false;
        dock-fixed = true;
        custom-theme-shrink = true;
        custom-background-color = true;
        isolate-workspaces = true;
        show-apps-at-top = true;
        background-color = "rgb(0,0,0)";
        running-indicator-style = "DOTS";
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Numix-Square";
      package = pkgs.numix-icon-theme-square;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  xresources.properties = {
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintslight";
    "Xft.hinting" = true;
    "Xft.antialias" = true;
    "Xft.rgba" = "rgb";
  };
}
