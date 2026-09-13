{ ... }:

{
  boot.kernel.sysctl = {
    "vm.swappiness" = 150;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_bytes" = 268435456;
    "vm.dirty_background_bytes" = 67108864;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.page-cluster" = 0;

    "kernel.nmi_watchdog" = 0;
    "kernel.unprivileged_userns_clone" = 1;
    "kernel.kptr_restrict" = 1;

    "kernel.printk" = "3 3 3 3";
    "net.core.netdev_max_backlog" = 4096;
    "fs.file-max" = 2097152;
  };
}
