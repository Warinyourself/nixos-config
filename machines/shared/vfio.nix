let
  # https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/
  # RTX 3050
  gpuIDs = [
    "10de:25a0" # Graphics
    "10de:2291" # Audio
  ];
in { pkgs, lib, config, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  # SPICE redirection lets you essentially hotplug USB keyboards, mice, storage, etc. from the host into the guest which is always nice and fun.
  virtualisation.spiceUSBRedirection.enable = true;

  hardware.opengl.enable = true;

  boot = {
    kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "vfio_virqfd"
    ];

    kernelParams = [
      # enable IOMMU
      "intel_iommu=on"
      "iommu=pt"
    ] ++ 
      # ++ lib.optional cfg.enable
      # isolate the GPU
      [("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)];
  };
}