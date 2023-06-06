{ config, pkgs, lib, currentSystem, currentSystemName, ... }:
let
  # Путь до файла со списком раширений.
  vscodeExt = lib.importJSON ./shared/vscode/extensions/vscode.json;
in {
  imports = [
    ./shared/syncthing.nix
    ./shared/vscode/vscode.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  networking = {
    hostName = "atom"; # Define your hostname.
    networkmanager = {
      enable = true;
    };
  };

  services.resolved = {
    enable = true;
  };
  
  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services = {
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;

      # Enable automatic login for the user.
      displayManager.autoLogin = {
        enable = true;
        user = "warinyourself";
      };
    };

    # Enable CUPS to print documents.
    # printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this.
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # And ensure gnome-settings-daemon udev rules are enabled :
    # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  vscode = {
    user = "warinyourself";
    homeDir = "/home/warinyourself";
    extensions = with pkgs.vscode-extensions; [ ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace vscodeExt;
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = with pkgs; [
    fd # A simple, fast and user-friendly alternative to find.
    jq # A lightweight and flexible command-line JSON processor.
    git # Distributed version control system.
    git-crypt # Transparent file encryption in git.
    gnupg # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation.
    fzf # A command-line fuzzy finder written in Go.
    zsh # The Z shell.
    bat # A cat(1) clone with syntax highlighting and Git integration.
    curl # A command line tool for transferring files with URL syntax.
    tree # Command to produce a depth indented directory listing.
    htop # An interactive process viewer.
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP.
    unzip # An extraction utility for archives compressed in .zip format.
    killall # killall
    ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
    screenfetch # Fetches system/theme information in terminal for Linux desktop screenshots

    lshw # Provide detailed information on the hardware configuration of the machine.
    usbutils # Tools for working with USB devices, such as lsusb.
    pciutils # A collection of programs for inspecting and manipulating configuration of PCI devices, such as lspci.

    gcc # GNU Compiler Collection.
    cmake # Cross-platform, open-source build system generator.
    meson # An open source, fast and friendly build system made in Python.
    gnumake # A tool to control the generation of non-source files from sources. ?
    mesa-demos # Collection of demos and test programs for OpenGL and Mesa.
    pkg-config # A tool that allows packages to find out information about other packages (wrapper script). ?

    cudatoolkit # A compiler for NVIDIA GPUs, math libraries, and tools.

    neovim # Vim text editor fork focused on extensibility and agility.

    libreoffice-fresh # Comprehensive, professional-quality productivity suite, a variant of openoffice.org.
    fragments # Easy to use BitTorrent client for the GNOME desktop environment.
    bleachbit # A program to clean your computer.

    baobab # Graphical application to analyse disk usage in any GNOME environment.

    firefox # A web browser built from Firefox source tree.
    gparted # Graphical disk partitioning tool.
    vlc # Cross-platform media player and streaming server.

    easytag # View and edit tags for various audio files.
    picard # The official MusicBrainz tagger.
    amberol # A small and simple sound and music player.

    tdesktop # Telegram Desktop messaging app. ? (не ставится в home-manager)
    blender # 3D Creation/Animation/Publishing System.

    gnome.gedit # Official text editor of the GNOME desktop environment.
    gnome-icon-theme # Collection of icons for the GNOME 2 desktop. ?
    gnome.gnome-terminal # The GNOME Terminal Emulator
    gnome.gnome-tweaks # A tool to customize advanced GNOME 3 options
    gnome.dconf-editor # GSettings editor for GNOME
  ];

  services.spice-vdagentd.enable = true;

  # Настройка для работы nvidia в blender
  nixpkgs.config.packageOverrides = self : rec {
    blender = self.blender.override {
      cudaSupport = true;
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # services.flatpak.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour # GNOME Greeter & Tour.
    gnome-console # Simple user-friendly terminal emulator for the GNOME desktop.
  ]) ++ (with pkgs.gnome; [
    epiphany # WebKit based web browser for GNOME.
    geary # Mail client for GNOME 3.
    tali # Sort of poker with dice and less money.
    iagno # Computer version of the game Reversi, more popularly called Othello.
    yelp # The help viewer in Gnome.
    hitori # GTK application to generate and let you play games of Hitori.
    atomix # Puzzle game where you move atoms to build a molecule.
    seahorse # Application for managing encryption keys and passwords in the GnomeKeyring.
    simple-scan # Simple scanning utility.
    gnome-maps # A  map application for GNOME 3.
    gnome-weather # Access current weather conditions and forecasts.
    gnome-contacts # GNOME’s integrated address book.
    gnome-characters # Simple utility application to find and insert unusual characters.
    gnome-disk-utility # A udisks graphical front-end.
  ]);

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["electron-12.2.3"]; # electron for ethcer
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";
}