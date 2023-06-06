{ lib, pkgs, ... }: {
  dconf.settings = {
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
