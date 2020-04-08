rm -r -f initramfs-part2
mkdir -p initramfs-part2/usr/libexec/
cp coreos-installer initramfs-part2/usr/libexec/coreos-installer
cd initramfs-part2
echo "Archive part2"
find . 2>/dev/null | cpio  --quiet -H newc -o > ../rhcos-install-part2.img.raw
echo "Compress part2"
cat ../rhcos-install-part2.img.raw | gzip -9 -c > ../rhcos-install-part2.img
cd ..
echo "Concat parts"
cat rhcosinstall-initramfs.img rhcos-install-part2.img > rhcos-install-new.img

