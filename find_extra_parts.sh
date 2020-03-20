sfdisk -d /dev/sda > disk-before.sfdisk
export basedisk=`cat disk-before.sfdisk | sed -n -e 's/^.*device: //p'`
echo "Base Disk"
echo $basedisk
awk -v RS='\n\n' 'END{printf "%s",$0}' disk-before.sfdisk > partitions.before
echo "Starting Paritions"
cat partitions.before
export cntpartsbefore=`wc -l partitions.before | awk '{ print $1 }'`
echo "Partitions Before Install"
echo $cntpartsbefore
tail -n +5 partitions.before > partitions.extra
echo "Extra Partitions"
cat partitions.extra

