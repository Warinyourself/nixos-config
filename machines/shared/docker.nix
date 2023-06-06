{ config, lib, pkgs, ... }:
{
  # Manage the virtualisation services
  virtualisation = {
    docker = {
      enable = true;
      # For fix issue (https://github.com/NixOS/nixpkgs/issues/182916#issuecomment-1364504677)
      liveRestore = false;
    };
  };

  # users.users.warinyourself.extraGroups = [ "docker" ];
  users.extraGroups.docker.members = [ "warinyourself" ];

  environment.systemPackages = with pkgs; [        
    dive # A tool for exploring each layer in a docker image.
    docker-compose # Docker CLI plugin to define and run multi-container applications with Docker.
  ]
}
