#export mversion=4.5
#export version=4.5.1
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
wget -nc ${srcinstinitrd} -O ${instinitrd}
wget -nc ${srcimg} -O ${img}
wget -nc ${srcimg}.sig -O ${img}.sig
wget -nc ${srcinstkernel} -O ${instkernel}
echo "Sending to: "  ${target}
echo "Copy "  ${instinitrd}
scp ${instinitrd} ${target}
echo "Copy "  ${img}
scp ${img} ${target}
echo "Copy "  ${img}.sig
scp ${img}.sig ${target}
echo "Copy " ${instkernel}
scp ${instkernel} ${target}

