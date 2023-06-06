{ config, lib, pkgs, ... }:
{
  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };

    spiceUSBRedirection.enable = true;
  };

  environment.systemPackages = with pkgs; [        
    qemu # A generic and open source machine emulator and virtualizer.
    virt-manager # Desktop user interface for managing virtual machines.
  ];
}
