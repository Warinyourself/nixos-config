{ config, lib, pkgs, modulesPath, ... }:

let
    nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{  
  #Nvidia Settings
  hardware.opengl = {
    enable = true;
    # https://nixos.org/manual/nixos/stable/options.html#opt-hardware.opengl.driSupport
    driSupport = true;
    driSupport32Bit = true;
  };

  environment.systemPackages = [ nvidia-offload ];
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    nvidiaSettings = true;

    # Required for amdgpu and nvidia gpu pairings.
    # modesetting.enable = true;

    # powerManagement.enable = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    prime = {
      offload.enable = true;
      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:1:0:0";
      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
      intelBusId = "PCI:0:2:0";
    };
  };
}
