export XDATAURL=`cat /proc/cmdline | sed -e 's/^.*xdata=//' -e 's/ .*$//'`
echo ${XDATAURL}

