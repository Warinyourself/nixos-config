{ lib, pkgs, ... }: {
  dconf.settings = {
    "org/gnome/desktop/app-folders".folder-children=["Utilities" "1e14a022-3b53-4616-a07e-91786008059e"];

    "org/gnome/desktop/app-folders/folders/1e14a022-3b53-4616-a07e-91786008059e" = {
      apps = ["org.keepassxc.KeePassXC.desktop" "rest.insomnia.Insomnia.desktop" "balena-etcher.desktop"];
      name = "Полезное";
      translate = false;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = ["org.gnome.baobab.desktop" "ca.desrt.dconf-editor.desktop" "org.gnome.Evince.desktop" "org.gnome.Connections.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.eog.desktop" "org.gnome.tweaks.desktop" "gparted.desktop" "org.gnome.font-viewer.desktop" "org.freedesktop.GnomeAbrt.desktop" "org.gnome.TextEditor.desktop" "org.gnome.Weather.desktop" "org.fedoraproject.MediaWriter.desktop"];
      categories = ["X-GNOME-Utilities"];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/shell".disabled-extensions = ["apps-menu@gnome-shell-extensions.gcampax.github.com"];
    "org/gnome/shell".favorite-apps=["brave-browser.desktop" "org.telegram.desktop.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Settings.desktop" "obsidian.desktop" "code.desktop" "org.gnome.Terminal.desktop" "blender.desktop"];
  };
}
