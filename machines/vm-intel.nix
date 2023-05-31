{ config, pkgs, ... }: {
  imports = [ ./vm-shared.nix ./nvidia.nix ];

  virtualisation.vmware.guest.enable = true;
}
