#export firstpart=`cat /tmp/partitions.before | head -n 1 | awk {'print $4'} | tr -d ',' `
export firstpart=`cat /tmp/partitions.before | head -n 1 | awk {'print $1'} | grep -Eo '[0-9]+$' `
echo $firstpart

