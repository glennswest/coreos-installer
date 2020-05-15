export kernelcmdline=`cat /proc/cmdline`
if [[ $kernelcmdline == *"xdata="* ]]; 
then
      export XDATAURL=`cat /proc/cmdline | sed -e 's/^.*xdata=//' -e 's/ .*$//'`
      echo ${XDATAURL}
      mkdir -p /var/mnt/datastore
      mount /dev/sda5 /var/mnt/datastore
      curl ${XDATAURL} -o /var/mnt/datastore/"${XDATAURL##*/}"
      umount /var/mnt/datastore
else
      echo "No XDATAURL provided"
fi


