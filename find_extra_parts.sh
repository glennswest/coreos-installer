sfdisk -d /dev/sda > /tmp/disk-before.sfdisk
export basedisk=`cat /tmp/disk-before.sfdisk | sed -n -e 's/^.*device: //p'`
echo "Base Disk"
echo $basedisk
awk -v RS='\n\n' 'END{printf "%s",$0}' /tmp/disk-before.sfdisk > /tmp/partitions.before
echo "Starting Paritions"
cat /tmp/partitions.before
export cntpartsbefore=`wc -l /tmp/partitions.before | awk '{ print $1 }'`
echo "Partitions Before Install"
echo $cntpartsbefore
tail -n +5 /tmp/partitions.before > /tmp/partitions.extra
echo "Extra Partitions"
cat partitions.extra
head -4 /tmp/partitions.before > /tmp/partitions.delete
echo "Partitions to delete"
cat /tmp/partitions.delete
sed -e '/^$/,$d' < /tmp/disk-before.sfdisk > /tmp/head.sfdisk
cp /tmp/head.sfdisk /tmp/mindisk.sfdisk
echo -en '\n' >> /tmp/mindisk.sfdisk
cat /tmp/partitions.extra >> /tmp/mindisk.sfdisk
echo "Blank Partition Table"
cat /tmp/mindisk.sfdisk

