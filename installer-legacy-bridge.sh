export img=`cat /proc/cmdline | sed -e 's/^.*coreos.inst.image_url=//' -e 's/ .*$//'`
export install_dev=`cat /proc/cmdline | sed -e 's/^.*coreos.inst.install_dev=//' -e 's/ .*$//'`
export ignurl=`cat /proc/cmdline | sed -e 's/^.*coreos.inst.ignition_url=//' -e 's/ .*$//'`
export kcmdline=`cat /proc/cmdline`
echo "Kernel Command Line: "${kcmdline}
echo "Image:              "${img}
echo "Destination Device: "${install_dev}
echo "Ignition:           "${ignurl}
/usr/libexec/new-coreos-installer install /dev/${install_dev}  --insecure --image-url ${img} --ignition-url ${ignurl} --insecure-ignition --dsneeded | cat > /dev/console
echo "Installed Exited"
reboot --force

