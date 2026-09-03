{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/REPLACE_WITH_ROOT_UUID";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd:3" "noatime" "discard=async" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/REPLACE_WITH_ROOT_UUID";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd:3" "noatime" "discard=async" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/REPLACE_WITH_ROOT_UUID";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd:3" "noatime" "discard=async" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/REPLACE_WITH_ROOT_UUID";
      fsType = "btrfs";
      options = [ "subvol=@log" "compress=zstd:3" "noatime" "discard=async" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/REPLACE_WITH_BOOT_UUID";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
