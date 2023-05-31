{ pkgs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.warinyourself = {
    isNormalUser = true;
    description = "Warinyourself";
    home = "/home/warinyourself";
    hashedPassword = "$y$j9T$sjzaHvEAhnu4O5CfJjjUf0$dtIFzsxEhOPw0.80xd7M5DIEELP.BhvVlQ6a5L2lTr1";
    extraGroups = [
      "libvirtd"
      "docker"
      "wheel"
      "networkmanager"
    ];
  };
}
