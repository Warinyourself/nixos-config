{ config, pkgs, ... }: {
  imports = [ ./vm-shared.nix ];

  virtualisation.vmware.guest.enable = true;
}
