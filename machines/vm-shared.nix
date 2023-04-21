# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config, pkgs, lib, currentSystem, currentSystemName, ...
}:

let
  # Путь до файла со списком раширений
  vscodeExt = lib.importJSON ./shared/vscode/extensions/vscode.json;
in {
  imports = [
    ./shared/vscode/vscode.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
  };

  networking = {
    useDHCP = false;
    firewall.enable = false; # Sure, why not?
    dhcpcd.enable = false; # Handled by `networkd`, can be disabled.

    hostName = "atom"; # Define your hostname.
    networkmanager = {
      enable = true;
    };
  };

  services.resolved = {
    enable = true;
  };
  
  networking.resolvconf.dnsExtensionMechanism = false;

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
      # If you want to use JACK applications, uncomment this
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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    jq
    git
    curl
    htop
    wget
    unzip
    killall
    screenfetch

    tdesktop
    baobab
    brave
    firefox
    gparted
    etcher
    webtorrent_desktop
    obsidian
    
    libvncserver
    vscode
    insomnia
    keepassxc
    teams
    openvpn
    update-systemd-resolved
    nodejs-16_x

    rhythmbox

    gnome.gedit
    gnome-icon-theme
    gnome.gnome-music
    gnome.gnome-terminal
    gnome.gnome-remote-desktop
    gnome.gnome-tweaks
    gnome.dconf-editor
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-console
  ]) ++ (with pkgs.gnome; [
    epiphany # web browser
    geary # email reader
    tali # poker game
    iagno # go game
    yelp # gnome help
    hitori # sudoku game
    atomix # puzzle game
    seahorse # gnome password manager
    simple-scan
    gnome-maps
    gnome-weather
    gnome-contacts
    gnome-characters
    gnome-disk-utility
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
  system.stateVersion = "22.11";
}