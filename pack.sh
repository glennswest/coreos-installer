#cp coreos-installer initramfs-part2/usr/libexec/coreos-installer
rm rhcos-install-part2.img
rm rhcos-install-part1.img
cd initramfs-part1
echo "Archive part1"
find . 2>/dev/null | cpio -H newc -o  > ../rhcos-install-part1.img 
cd ..
cd initramfs-part2
echo "Archive part2"
find . 2>/dev/null | cpio -H newc -o > ../rhcos-install-part2.img.raw
echo "Compress part2"
cat ../rhcos-install-part2.img.raw | gzip -c > ../rhcos-install-part2.img
cd ..
echo "Concat parts"
cat rhcos-install-part1.img rhcos-install-part2.img > rhcos-install-new.img

