#!/bin/bash 

#### Logging reports confluence services ####


## ssh into confluencedev1.daicompanies.com(sub any vm for testing) 
## check if confluence services is running, 
## if not running, sendmail to wonops 


## VARIABLES ## 
ROOT_UID=0
E_NONROOT=87
VM=192.168.122.150
LOGFILE=/home/mcbeeff/alertlog.txt


if [ $UID -ne $ROOT_UID ] 
then
	echo "You must have root permissions to execute this script" ## TODO: create a user to run this with non-root
							             ##       permissions
	exit $E_NONROOT
fi


## Check if host is up 

ping -q -w 1 $VM

let error=$(echo $?)
if [ $error -ne 0 ]
then
	echo "ICMP request failed to reach $VM";  echo
	echo "Exiting"
	exit 
else
	remote_init ## remotes into server and runs checks
fi



remote_init(){
	
	date  echo  "Status : $VM is up " >> $LOGFILE; echo 
	ssh -i ~/.ssh/server1 root@$VM 	'echo "Checking confluence services.."; echo ; test'
					 ## change variable to conflunce server when ready			
				 	 ## TODO :: 
 	#systemctl status 		 ## determine best way to confirm confluence services is runniing 
			 		 ## Check java services, confluence/status url links, etc
	



}
check(){
	for file in $LOGFILE
	do
		if [ ! -e "$file" ] 
		then
			touch /home/mcbeeff/aertlog.txt ## checking if our log file exists on machine, if not then
			echo "log file created"         ## create one
		fi
	done
}


remote_init
check

exit 0; 
