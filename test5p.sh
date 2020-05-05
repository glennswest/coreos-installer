# must yum install bc
umount /mnt/dl
cp /root/coreos-installer/images/rhcos-4.3.0-x86_64-metal.raw.gz.save /root/coreos-installer/images/rhcos-4.3.0-x86_64-metal.raw.gz
sfdisk  /dev/sda < tools/disk5p.sfdisk
rm /tmp/curl-rc
rm /tmp/image_info
rm /tmp/image_url
./coreos-installer -d sda -i file:/root/coreos-installer/tools/base.ignition -b file:/root/coreos-installer/images/rhcos-4.3.0-x86_64-metal.raw.gz

