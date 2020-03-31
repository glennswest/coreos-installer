#sfdisk -d /dev/sda > /tmp/disk-before.sfdisk
sfdisk -d /dev/sda > /tmp/disk-after.sfdisk
cp /tmp/disk-after.sfdisk /tmp/disk-final.sfdisk
cat /tmp/partitions.extra >> /tmp/disk-final.sfdisk
sfdisk /dev/sda < /tmp/disk-final.sfdisk
echo "Final Result"
sfdisk -d /dev/sda

