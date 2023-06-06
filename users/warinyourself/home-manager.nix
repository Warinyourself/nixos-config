{ config, lib, pkgs, ... }: {
  imports = [
    ./nvim.nix
    ./vscode.nix
    ./openvpn.nix
    ./gnome/gnome.nix
  ];

  home.stateVersion = "23.05";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------
  home.packages = [
    pkgs.veracrypt # Free Open-Source filesystem on-the-fly encryption.
    pkgs.keepassxc # Offline password manager with many features.

    pkgs.freecad # General purpose Open Source 3D CAD/MCAD/CAx/CAE/PLM modeler.
    pkgs.kicad # Open Source Electronics Design Automation suite.

    pkgs.openvpn # A robust and highly flexible tunneling application.
    pkgs.update-systemd-resolved # Helper script for OpenVPN to directly update the DNS settings of a link through systemd-resolved via DBus.

    pkgs.krita # A free and open source painting application.
    pkgs.mattermost-desktop # Mattermost Desktop client.
    pkgs.insomnia # The most intuitive cross-platform REST API Client.
    pkgs.figma-linux # Unofficial Electron-based Figma desktop app for Linux.

    pkgs.brave # Privacy-oriented browser for Desktop and Laptop computers.
    pkgs.chromium # An open source web browser from Google.
    pkgs.obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files.
    pkgs.etcher # Flash OS images to SD cards and USB drives, safely and easily.
    pkgs.vscode # Open source source code editor developed.

    pkgs.yarn # Fast, reliable, and secure dependency management for javascript.
    pkgs.nodejs-16_x # Event-driven I/O framework for the V8 JavaScript engine.
    pkgs.python39 # A high-level dynamically-typed programming language.
    pkgs.jstest-gtk # A simple joystick tester based on Gtk+.
    # pkgs.segger-jlink # J-Link Software and Documentation pack

    pkgs.dmidecode # A tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard.
  ];

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------
  programs.bash = {
    enable = true;
    shellOptions = [];
    historyControl = [ "ignoredups" "ignorespace" ];

    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gdiff = "git diff";
      gl = "git prettylog";
      gp = "git push";
      gs = "git status";
      gt = "git tag";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]);

    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gdiff = "git diff";
      gl = "git prettylog";
      gp = "git push";
      gs = "git status";
      gt = "git tag";
    };
  };

  home.file = {
    "./Documents/Programming/.stignore".text = ''
      **/node_modules
      **/dist
      **/.nuxt
      **/.next
      **/.yarn
    '';
  };

  programs.git = {
    enable = true;
    userName = "Warinyourself";
    userEmail = "warinyourself@gmail.com";
    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
      core.editor = "nvim";
    };
  };
}
