rm -r -f initramfs-part1
rm -r -f initramfs-part2
mkdir initramfs-part1
mkdir initramfs-part2
cd initramfs-part1
cat ../rhcosinstall-initramfs.img |  cpio -idmv
cd ..
cd initramfs-part2
/usr/lib/dracut/skipcpio ../rhcosinstall-initramfs.img | gunzip -c | cpio -idm 

