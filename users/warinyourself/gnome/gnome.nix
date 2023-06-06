{ lib, pkgs, ... }: 
let
  inherit (lib.hm.gvariant) mkTuple type;
in {
  imports = [
    ./extentions.nix
    ./folders.nix
    ./keybinds.nix
  ];

  dconf.settings = {
    # Set the theme
    "org/gnome/shell/extensions/user-theme" = {
      name="Orchis-Pink-Dark-Compact";
    };

    "org/gnome/desktop/calendar".show-weekdate = false;
    "org/gnome/desktop/datetime".automatic-timezone = true;

    "org/gnome/desktop/input-sources".sources = [(mkTuple ["xkb" "us"]) (mkTuple ["xkb" "ru"])];
    "org/gnome/desktop/input-sources".xkb-options = ["grp:caps_toggle" "ctrl:swap_lalt_lctl" "lv3:switch"];

    "org/gnome/desktop/peripherals/mouse".speed = 0.8;
    "org/gnome/desktop/peripherals/touchpad" = {
      speed = 1.0;
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      # Enable touchpad while typing
      disable-while-typing = false;
    };

    "org/gnome/desktop/privacy".report-technical-problems = true;

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      show-battery-percentage = true;

      ## Theme stuff
      cursor-theme = "Adwaita";
      gtk-theme="Adwaita-dark";
      icon-theme = "Adwaita";

      ## Clock
      clock-show-weekday = true;
      clock-show-date = true;

      ## Font stuff
      font-antialiasing = "rgba";
      font-hinting = "slight";
    };

    "org/gnome/shell/app-switcher".current-workspace-only = true;
    "org/gnome/desktop/wm/preferences".num-workspaces = 6;
    "system/locale".region = "ru_RU.UTF-8";

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = false;
      edge-tiling = true;
      workspaces-only-on-primary = true;
    };
  };
}
