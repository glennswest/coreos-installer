sfdisk -d /dev/sda > /tmp/disk-before.sfdisk
export basedisk=`cat /tmp/disk-before.sfdisk | sed -n -e 's/^.*device: //p'`
echo "Base Disk"
echo $basedisk
awk -v RS='\n\n' 'END{printf "%s",$0}' /tmp/disk-before.sfdisk > /tmp/partitions.before
echo "Starting Paritions"
cat /tmp/partitions.before
export firstpart=`cat /tmp/partitions.before | head -n 1 | awk {'print $1'} | grep -Eo '[0-9]+$' `
echo "First Partition Number"
echo $firstpart
case $firstpart in
     1)
     export cntpartsbefore=`wc -l /tmp/partitions.before | awk '{ print $1 }'`
     echo "Partitions Before Install"
     echo $cntpartsbefore
     tail -n +5 /tmp/partitions.before > /tmp/partitions.extra
     echo "Extra Partitions"
     cat /tmp/partitions.extra
     head -4 /tmp/partitions.before > /tmp/partitions.delete
     echo "Partitions to delete"
     cat /tmp/partitions.delete
     sed -e '/^$/,$d' < /tmp/disk-before.sfdisk > /tmp/head.sfdisk
     cp /tmp/head.sfdisk /tmp/mindisk.sfdisk
     echo -en '\n' >> /tmp/mindisk.sfdisk
     cat /tmp/partitions.extra >> /tmp/mindisk.sfdisk
     echo "Blank Partition Table"
     cat /tmp/mindisk.sfdisk
     ;;
     5)
     cp /tmp/disk-before.sfdisk /tmp/mindisk.sfdisk
     ;;
     0) 
     echo "Disk is empty - using basic config"
     cat >> /tmp/mindisk.sfdisk << EOF
label: gpt
label-id: 5DF49930-8329-4F2F-93C8-03D4AB5D1E19
device: /dev/sda
unit: sectors
first-lba: 34

/dev/sda5 : start=   247220224, type=EBD0A0A2-B9E5-4433-87C0-68B6B72699C7, uuid=DED9849F-E33B-4F7F-8280-47E296F76698, name="datastore"
EOF
     ;;

esac
echo "Writing mindisk before install"
sfdisk /dev/sda < /tmp/mindisk.sfdisk
echo "Result"
sfdisk -d /dev/sda

