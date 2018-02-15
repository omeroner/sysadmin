
## — Vmware yeni disk ekle.

## — Eklenen diski aşağıdaki şekilde gör.
```sh
[root@datingslave6 ~]$ls -l /dev/sd*
brw-rw---- 1 root disk 8,  0 Jan  9 11:30 /dev/sda
brw-rw---- 1 root disk 8,  1 Jan  9 11:30 /dev/sda1
brw-rw---- 1 root disk 8,  2 Jan  9 11:30 /dev/sda2
brw-rw---- 1 root disk 8,  3 Jan  9 11:30 /dev/sda3
brw-rw---- 1 root disk 8, 16 Jan  9 11:30 /dev/sdb
```

## — diski fdisk yardımı ile bölümlendirelim.

```sh
[root@datingslave6 ~]$fdisk /dev/sdb
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
Building a new DOS disklabel with disk identifier 0x734c4676.
Changes will remain in memory only, until you decide to write them.
After that, of course, the previous content won't be recoverable.

Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)

WARNING: DOS-compatible mode is deprecated. It's strongly recommended to
         switch off the mode (command 'c') and change display units to
         sectors (command 'u').

Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
p
Partition number (1-4): 1
First cylinder (1-9137, default 1): enter
Using default value 1
Last cylinder, +cylinders or +size{K,M,G} (1-9137, default 9137): enter
Using default value 9137
Command (m for help): p

Disk /dev/sdb: 75.2 GB, 75161927680 bytes
255 heads, 63 sectors/track, 9137 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x734c4676

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        9137    73392921   83  Linux

Command (m for help): t
Selected partition 1
Hex code (type L to list codes): 8e
Changed system type of partition 1 to 8e (Linux LVM)

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
[root@datingslave6 ~]$
```

## — volume group  listele
```sh
[root@datingslave6 ~]$vgs
  VG        #PV #LV #SN Attr   VSize VFree
  vg_magnet   2   5   0 wz--n- 4.65g    0
[root@datingslave6 ~]$
```

## — fiziksel disk yarat
```sh
[root@datingslave6 ~]$pvcreate /dev/sdb1
  dev_is_mpath: failed to get device for 8:17
  Physical volume "/dev/sdb1" successfully created
[root@datingslave6 ~]$
```

## — logical volume listele
```sh
[root@datingslave6 ~]$lvmdiskscan
  /dev/ram0               [      16.00 MiB]
  /dev/root               [       2.43 GiB]
  /dev/ram1               [      16.00 MiB]
  /dev/sda1               [     500.00 MiB]
  /dev/vg_magnet/lv_swap  [       1.00 GiB]
  /dev/ram2               [      16.00 MiB]
  /dev/sda2               [       4.51 GiB] LVM physical volume
  /dev/vg_magnet/LogVol04 [     248.00 MiB]
  /dev/ram3               [      16.00 MiB]
  /dev/sda3               [     149.04 MiB] LVM physical volume
  /dev/vg_magnet/LogVol03 [     252.00 MiB]
  /dev/ram4               [      16.00 MiB]
  /dev/vg_magnet/LogVol02 [     752.00 MiB]
  /dev/ram5               [      16.00 MiB]
  /dev/ram6               [      16.00 MiB]
  /dev/ram7               [      16.00 MiB]
  /dev/ram8               [      16.00 MiB]
  /dev/ram9               [      16.00 MiB]
  /dev/ram10              [      16.00 MiB]
  /dev/ram11              [      16.00 MiB]
  /dev/ram12              [      16.00 MiB]
  /dev/ram13              [      16.00 MiB]
  /dev/ram14              [      16.00 MiB]
  /dev/ram15              [      16.00 MiB]
  /dev/sdb1               [      69.99 GiB] LVM physical volume
  2 disks
  20 partitions
  0 LVM physical volume whole disks
  3 LVM physical volumes
[root@datingslave6 ~]$
```

## — fiziksel diskleri listele
```sh
[root@datingslave6 ~]$pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda2
  VG Name               vg_magnet
  PV Size               4.51 GiB / not usable 3.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              1154
  Free PE               0
  Allocated PE          1154
  PV UUID               ZVqc4x-Rf1Z-VC2d-Uj9m-G0ou-JPKC-6utcvm

  --- Physical volume ---
  PV Name               /dev/sda3
  VG Name               vg_magnet
  PV Size               149.04 MiB / not usable 1.04 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              37
  Free PE               0
  Allocated PE          37
  PV UUID               JIAjLo-CoaQ-ELRI-BP9a-crtg-HA1b-iF0FBG

  "/dev/sdb1" is a new physical volume of "69.99 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sdb1
  VG Name
  PV Size               69.99 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               oJ0hv6-y8Ut-tv52-9plM-3QPR-B2n2-tCXdli

[root@datingslave6 ~]$


[root@datingslave6 ~]$pvscan
  PV /dev/sda2   VG vg_magnet       lvm2 [4.51 GiB / 0    free]
  PV /dev/sda3   VG vg_magnet       lvm2 [148.00 MiB / 0    free]
  PV /dev/sdb1                      lvm2 [69.99 GiB]
  Total: 3 [74.65 GiB] / in use: 2 [4.65 GiB] / in no VG: 1 [69.99 GiB]
[root@datingslave6 ~]$
```

## — ilgili volume gruba yeni disk bölümünü ekle

```sh
[root@datingslave6 ~]$vgs
  VG        #PV #LV #SN Attr   VSize VFree
  vg_magnet   2   5   0 wz--n- 4.65g    0
[root@datingslave6 ~]$vgextend vg_magnet /dev/sdb1
  Volume group "vg_magnet" successfully extended
[root@datingslave6 ~]$
```

## — logical volume listele
```sh
[root@datingslave6 ~]$lvdisplay
  --- Logical volume ---
  LV Path                /dev/vg_magnet/LogVol04
  LV Name                LogVol04
  VG Name                vg_magnet
  LV UUID                jxRiLL-J9mR-GI1r-vU7O-Zy0J-6Kva-Ys44yS
  LV Write Access        read/write
  LV Creation host, time ,
  LV Status              available
  # open                 1
  LV Size                248.00 MiB
  Current LE             62
  Segments               2
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:2

  --- Logical volume ---
  LV Path                /dev/vg_magnet/lv_root
  LV Name                lv_root
  VG Name                vg_magnet
  LV UUID                UR2gQv-UhVb-yKTo-DtHD-o1dU-Kn8J-MswToO
  LV Write Access        read/write
  LV Creation host, time ,
  LV Status              available
  # open                 1
  LV Size                2.43 GiB
  Current LE             622
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:0

  --- Logical volume ---
  LV Path                /dev/vg_magnet/lv_swap
  LV Name                lv_swap
  VG Name                vg_magnet
  LV UUID                Vq3C6s-vcJa-uKEz-QwKl-A7tV-OSYD-HMFL1S
  LV Write Access        read/write
  LV Creation host, time ,
  LV Status              available
  # open                 1
  LV Size                1.00 GiB
  Current LE             256
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:1

  --- Logical volume ---
  LV Path                /dev/vg_magnet/LogVol03
  LV Name                LogVol03
  VG Name                vg_magnet
  LV UUID                Gbg3Cs-jcQk-dBOZ-ogVz-IfUT-8hAZ-BAY6oQ
  LV Write Access        read/write
  LV Creation host, time ,
  LV Status              available
  # open                 1
  LV Size                252.00 MiB
  Current LE             63
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:3

  --- Logical volume ---
  LV Path                /dev/vg_magnet/LogVol02
  LV Name                LogVol02
  VG Name                vg_magnet
  LV UUID                dd4Uq0-wAV6-W39b-31l9-qhHJ-TMV6-D3HFjw
  LV Write Access        read/write
  LV Creation host, time ,
  LV Status              available
  # open                 1
  LV Size                752.00 MiB
  Current LE             188
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:4

[root@datingslave6 ~]$
```

## — hangi volume extend edilecek ise extend edelim.

```sh
[root@datingslave6 ~]$vgdisplay
  --- Volume group ---
  VG Name               vg_magnet
  System ID
  Format                lvm2
  Metadata Areas        3
  Metadata Sequence No  9
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                5
  Open LV               5
  Max PV                0
  Cur PV                3
  Act PV                3
  VG Size               74.64 GiB
  PE Size               4.00 MiB
  Total PE              19108
  Alloc PE / Size       1191 / 4.65 GiB
  Free  PE / Size       17917 / 69.99 GiB
  VG UUID               eugQtb-oxNW-uoax-DJWx-W9Th-N8Gq-1o4LTl

[root@datingslave6 ~]$lvextend -L +69.98GiB /dev/vg_magnet/lv_root
  Rounding size to boundary between physical extents: 69.98 GiB
  Extending logical volume lv_root to 72.41 GiB
  Logical volume lv_root successfully resized
[root@datingslave6 ~]$
```

## — resize işlemi yapalım.
```sh
[root@datingslave6 ~]$resize2fs /dev/vg_magnet/lv_root
resize2fs 1.41.12 (17-May-2010)
Filesystem at /dev/vg_magnet/lv_root is mounted on /; on-line resizing required
old desc_blocks = 1, new_desc_blocks = 5
Performing an on-line resize of /dev/vg_magnet/lv_root to 18981888 (4k) blocks.
The filesystem on /dev/vg_magnet/lv_root is now 18981888 blocks long.
```
## — kontrol
```sh
[root@datingslave6 ~]$df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/vg_magnet-lv_root
                       72G  2.1G   66G   4% /
tmpfs                 3.9G     0  3.9G   0% /dev/shm
/dev/sda1             485M  121M  339M  27% /boot
/dev/mapper/vg_magnet-LogVol04
                      241M  6.1M  223M   3% /home
/dev/mapper/vg_magnet-LogVol03
                      245M  6.3M  226M   3% /tmp
/dev/mapper/vg_magnet-LogVol02
                      741M  726M     0 100% /var
saglayicinfs.magnet.local:/vol/datingsql_slave6
                      7.0T  2.3T  4.7T  33% /mnt/sql
[root@datingslave6 ~]$
```
