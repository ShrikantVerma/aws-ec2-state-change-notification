#!/bin/bash
#By Shrikant Verma.
#Script to delete ami with attached snapshots.

#cat /home/deploy/AV6/updatedamilistforav6.txt | awk '{print $2}' > /tmp/av6_amiid.txt

tail -n15 /home/deploy/AV6/updatedamilistforav6 | awk '{print $2}' > /tmp/av6_amiid.txt
head -n -4 /tmp/av6_amiid.txt > /tmp/av6_imageid.txt
#Take input of AMI to be deleted.
#echo -e "$1" > /tmp/imageid.txt
ami=`cat /tmp/av6_imageid.txt`
#Find snapshots associated with AMI.
#aws ec2 describe-images --image-ids `cat /tmp/imageid.txt` | grep snap | awk ' { print $4 }' > /tmp/snap.txt
#aws ec2 describe-images --image-ids `cat /tmp/imageid.txt` | grep SnapshotId | cut -d'"' -f4 > /tmp/snap.txt
aws ec2 describe-images --image-ids $ami | grep SnapshotId | cut -d'"' -f4 > /tmp/av6_snap.txt
#for ami in `cat /tmp/imageid.txt`; do aws ec2 describe-images --image-ids $ami | grep SnapshotId | cut -d'"' -f4 > /tmp/snap.txt;
#done

echo -e "Following are the snapshots associated with it : `cat /tmp/av6_snap.txt`:\n "

 echo -e "Starting the Deregister of AMI... \n"

#Deregistering the AMI
#aws ec2 deregister-image --image-id `cat /tmp/imageid.txt`
#aws ec2 deregister-image --image-id $ami
###########for s in `cat /tmp/av6_imageid.txt`; do aws ec2 deregister-image --image-id $s ; done

echo -e "\nDeleting the associated snapshots.... \n"

#Deleting snapshots attached to AMI
snapshot=`cat /tmp/av6_snap.txt`
#echo $snapshot
for i in `cat /tmp/av6_snap.txt`;do aws ec2 delete-snapshot --snapshot-id $i ; done
#for i in $snapshot;do aws ec2 delete-snapshot -/tmp/avdb_imageid.txt-snapshot-id $i ; done
#aws ec2 delete-snapshot --snapshot-id $snapshot
