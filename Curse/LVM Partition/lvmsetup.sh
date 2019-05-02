#!/bin/bash

#Create a single primary partiton with whole disk size and create LVM PV on it
#Also formats and mounts partition to specified folder
#Written by Matt McLane: 6/30/2015
#Written and tested on Ubuntu 14.04 LTS



disk=$1
mountpoint=$2
partno=1
if [[ -z $disk ]]; then
 echo "Usage: $0 {disk device} {mount point}: e.g $0 /dev/sdb /mnt/foo"
 exit
fi
 
 
if [[ -e ${disk}${partno} ]]; then
 echo "==> ${disk}${partno} already exist"
 exit
fi
 
if [[ -e ${mountpoint} ]]; then
  echo "==> ${mountpoint} already exists"
  exit
fi

echo "==> Create MBR label"
parted -s $disk  mklabel msdos
ncyl=$(parted $disk unit cyl print  | sed -n 's/.*: \([0-9]*\)cyl/\1/p')
 
if [[ $ncyl != [0-9]* ]]; then
 echo "disk $disk has invalid cylinders number: $ncyl"
 exit
fi
 
echo "==> create primary parition  $partno with $ncyl cylinders"
parted -a optimal $disk mkpart primary 0cyl ${ncyl}cyl
echo "==> set partition $partno to type: lvm "
parted $disk set $partno lvm on
partprobe > /dev/null 2>&1
echo "==> create PV ${disk}${partno} "
pvcreate ${disk}${partno}

echo "==> Formatting partition"
mkfs -t ext3 ${disk}${partno}

echo "==> Mounting ${disk}${partno} to $mountpoint"
mkdir $mountpoint
mount ${disk}${partno} $mountpoint

echo "==> task complete!"