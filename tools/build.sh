yum -y install dracut dracut-network
yum -y install $(grep inst_multiple dracut/30coreos-installer/module-setup.sh | sed 's|inst_multiple||' | tr '\n' ' ')
cp ./coreos-installer /usr/libexec/coreos-installer
rsync -avh dracut/30coreos-installer /usr/lib/dracut/modules.d/
dracut --kernel-cmdline="ip=dhcp rd.neednet=1" --add coreos-installer --no-hostonly -f ./initramfs.img --kver $(uname -r)

