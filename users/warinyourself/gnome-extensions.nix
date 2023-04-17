{ lib, pkgs, ... }: 
let
  gnomeExt =  with pkgs.gnomeExtensions; [
    appindicator
    blur-my-shell
    gsconnect
    vitals
  ];
  inherit (lib.hm.gvariant) mkTuple type;
in {
  home.packages = gnomeExt;

  dconf.settings = {
    # Folders
    "org/gnome/desktop/app-folders".folder-children=["Utilities" "1e14a022-3b53-4616-a07e-91786008059e"];

    "org/gnome/desktop/app-folders/folders/1e14a022-3b53-4616-a07e-91786008059e" = {
      apps = ["org.keepassxc.KeePassXC.desktop" "rest.insomnia.Insomnia.desktop" "balena-etcher.desktop" "syncthing-ui.desktop" "syncthing-start.desktop"];
      name = "Полезное";
      translate = false;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = ["org.gnome.baobab.desktop" "ca.desrt.dconf-editor.desktop" "org.gnome.Evince.desktop" "org.gnome.Connections.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.eog.desktop" "org.gnome.tweaks.desktop" "gparted.desktop" "org.gnome.font-viewer.desktop" "org.freedesktop.GnomeAbrt.desktop" "org.gnome.TextEditor.desktop" "org.gnome.Weather.desktop" "org.fedoraproject.MediaWriter.desktop"];
      categories = ["X-GNOME-Utilities"];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/shell".enabled-extensions =
      (map (extension: extension.extensionUuid) gnomeExt)
      # Then we add any extensions that come with gnome but aren"t enabled
      ++ [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];

    "org/gnome/shell".disabled-extensions = [];
    "org/gnome/shell".favorite-apps=["brave-browser.desktop" "org.telegram.desktop.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Settings.desktop" "obsidian.desktop" "code.desktop" "org.gnome.Terminal.desktop" "blender.desktop"];

    "org/gnome/shell/extensions/apps-menu" = {enabled = true;};
    "org/gnome/shell/extensions/appindicator".tray-pos = "right";

    "org/gnome/shell/extensions/vitals" = {
      hide-icons = false;
      hide-zeros = false;
      hot-sensors = ["_memory_usage_" "__temperature_avg__" "_processor_usage_" "_processor_frequency_"];
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

    # Keybindings
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      maximize= ["@as []"];
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
      move-to-workspace-5 = ["<Shift><Super>5"];
      move-to-workspace-6 = ["<Shift><Super>6"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      toggle-maximized= ["<Super>m"];
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [""];
      switch-to-application-2 = [""];
      switch-to-application-3 = [""];
      switch-to-application-4 = [""];
      switch-to-application-5 = [""];
      switch-to-application-6 = [""];
      switch-to-application-7 = [""];
      switch-to-application-8 = [""];
      switch-to-application-9 = [""];
      toggle-message-tray = ["<Super>n <Super>n"];
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = false;
      edge-tiling = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      calculator= ["<Shift><Super>c"];
      control-center = ["<Super>s"];
      custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"];

      home = ["<Super>e"];
      www = ["<Super>b"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>c";
      command = "code";
      name = "Vscode";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>z";
      command = "gnome-terminal";
      name = "Terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Shift><Super>b";
      command = "gnome-control-center bluetooth";
      name = "Bluetooth settings";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "<Shift><Super>w";
      command = "gnome-control-center wifi";
      name = "Wifi settings";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      binding = "<Shift><Super>s";
      command = "gnome-control-center sound";
      name = "Sounds settings";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
      binding = "<Super>t";
      command = "telegram";
      name = "Telegram";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6" = {
      binding = "<Super>c";
      command = "code";
      name = "Open vscode";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom7" = {
      binding = "<Super>b";
      command = "brave";
      name = "Open browser";
    };
  };
}
