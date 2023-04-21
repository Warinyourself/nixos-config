{ config, pkgs, ... }: {
  imports = [
    ./vm-shared.nix
  ];

  virtualisation.vmware.guest.enable = true;

  services.syncthing = {
    enable = true;
    overrideFolders = true;
    overrideDevices = true;
    user = "warinyourself";
    group = "users";
    configDir = "/home/warinyourself/.config/syncthing";
    devices = {
      Phone = { id = "O7RPI7X-O7EEEJO-TH55KF5-64PE6MS-RPFJZ5B-LIA2ZEW-GJVBCHS-76W54AP"; };
      Mini = {
        id = "B3L4UCS-XCXLFMZ-ZM5KSLB-M3J3K7C-2CVRHRF-T7YZBFE-4BJZXTE-FR26FQ4";
        autoAcceptFolders = true;
        introducer = true;
      };
    };
    folders = {
      Music = {
        label = "Музыка";
        id = "euzcf-p3zwk";
        path = "/home/warinyourself/Music";
        devices = ["Mini"];
      };
      Programming = {
        label = "Программирование";
        id = "9jncd-vg9ma";
        path = "/home/warinyourself/Documents/Programming";
        devices = ["Mini"];
      };
      Obsidian = {
        id = "m5wcz-xewiu";
        path = "/home/warinyourself/Documents/Obsidian";
        devices = ["Mini" "Phone"];
      };
      Sync = {
        id = "9duwu-wskkc";
        path = "/home/warinyourself/Documents/Sync";
        devices = ["Mini" "Phone"];
      };
    };
  };
}
