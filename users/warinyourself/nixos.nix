{ pkgs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.warinyourself = {
    isNormalUser = true;
    description = "Warinyourself";
    home = "/home/warinyourself";
    extraGroups = [ "docker" "wheel" "networkmanager"];
  };
}
