{ config, pkgs, ... }: {
  imports = [
    ./vm-shared.nix
    ./shared/nvidia.nix
    ./shared/virtualization.nix
    ./shared/mitmproxy/mitmproxy.nix
  ];

  virtualisation.vmware.guest.enable = true;
}
