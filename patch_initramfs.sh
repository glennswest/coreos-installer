source ./setupocpversion.sh
export base=ctl.gsw.lo
export target=root@${base}:/tftp/webroot/rhcos
echo "Target: " ${target}
export baseurl=https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/${mversion}/${version}
export instinitrd=rhcos-${version}-x86_64-installer-initramfs.x86_64.img
export instkernel=rhcos-${version}-x86_64-installer-kernel-x86_64
export img=rhcos-${version}-x86_64-metal.x86_64.raw.gz
export srcinstinitrd=${baseurl}/${instinitrd}
export srcimg=${baseurl}/${img}
export srcinstkernel=${baseurl}/${instkernel}

wget -nc ${baseurl}/${instinitrd} -O rhcosinstall-initramfs.img
rm -r -f initramfs-part2
mkdir -p initramfs-part2/usr/libexec/
mkdir -p initramfs-part2/usr/bin/
cp target/debug/coreos-installer initramfs-part2/usr/libexec/new-coreos-installer
cp installer-legacy-bridge.sh initramfs-part2/usr/libexec/coreos-installer
cp /usr/bin/gpg-agent initramfs-part2/usr/bin/gpg-agent
cd initramfs-part2
echo "Archive part2"
find . 2>/dev/null | cpio  --quiet -H newc -o > ../rhcos-install-part2.img.raw
echo "Compress part2"
cat ../rhcos-install-part2.img.raw | gzip -9 -c > ../rhcos-install-part2.img
cd ..
echo "Concat parts"
cat rhcosinstall-initramfs.img rhcos-install-part2.img > rhcos-install-new.img
rm rhcos-install-part2.img
rm -r -f initramfs-part2
rm -f rhcos-install-part2.img.raw
scp rhcos-install-new.img  ${target}/${instinitrd}
