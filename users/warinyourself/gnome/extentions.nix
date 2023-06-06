{ lib, pkgs, ... }: 
let
  gnomeExt =  with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    gsconnect
    vitals
  ];
in {
  home.packages = gnomeExt;

  dconf.settings = {
    "org/gnome/shell".enabled-extensions =
      (map (extension: extension.extensionUuid) gnomeExt)
      # Then we add any extensions that come with gnome but aren"t enabled
      ++ [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];

    "org/gnome/shell".disabled-extensions = ["apps-menu@gnome-shell-extensions.gcampax.github.com"];
    "org/gnome/shell".favorite-apps=["brave-browser.desktop" "org.telegram.desktop.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Settings.desktop" "obsidian.desktop" "code.desktop" "org.gnome.Terminal.desktop" "blender.desktop"];

    "org/gnome/shell/extensions/apps-menu" = { enabled = true; };
    "org/gnome/shell/extensions/appindicator".tray-pos = "right";

    "org/gnome/shell/extensions/vitals" = {
      hide-icons = false;
      hide-zeros = false;
      hot-sensors = ["_memory_usage_" "__temperature_avg__" "_processor_usage_"];
      use-higher-precision = false;
    };

    # Configure blur-my-shell
    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.85;
      dash-opacity = 0.25;
      sigma = 15; # Sigma means blur amount
      static-blur = true;
    };
    "org/gnome/shell/extensions/blur-my-shell/panel".blur = true;
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      blur = true;
      style-dialogs = 0;
    };

    # Configure GSConnect
    "org/gnome/shell/extensions/gsconnect".show-indicators = true;

    # Set the default window for primary applications
    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "firefox.desktop:6"
        "brave.desktop:1"
        "vscode.desktop:2"
        "telegram_desktop.desktop:4"
      ];
    };
  };
}
