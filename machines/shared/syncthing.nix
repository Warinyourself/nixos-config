{ config, pkgs, ... }: {
  services.syncthing = {
    enable = true;
    overrideFolders = true;
    overrideDevices = true;
    user = "warinyourself";
    group = "users";
    configDir = "/home/warinyourself/.config/syncthing";
    devices = {
      Phone = { id = "EUTO27W-EGP6CHA-PB3KBRE-MZ2ZXP3-YTJMA5Q-QQ3AXMS-X4GQEVN-CSLYLQD"; };
      Mini = {
        id = "B3L4UCS-XCXLFMZ-ZM5KSLB-M3J3K7C-2CVRHRF-T7YZBFE-4BJZXTE-FR26FQ4";
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
      Photo = {
        id = "ncbek-moerx";
        path = "/home/warinyourself/Pictures/Photo";
        ignoreDelete = true;
        type = "sendreceive"; # "sendreceive" (default), "sendonly", "receiveonly", "receiveencrypted"
        devices = ["Phone" "Mini"];
      };
      Wallpaper = {
        id = "Wallpaper";
        path = "/home/warinyourself/Pictures/WallPaper";
        devices = ["Mini"];
      };
      Info = {
        id = "hr6u4-vg3la";
        path = "/home/warinyourself/Documents/Info";
        devices = ["Mini"];
      };
      Blender = {
        id = "c9qnf-rd7ue";
        path = "/home/warinyourself/Documents/Blender";
        devices = ["Mini"];
      };
    };
  };
}
