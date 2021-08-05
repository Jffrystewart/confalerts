#!/bin/bash 

#### Logging reports confluence services ####


## ssh into confluencedev1.daicompanies.com(sub any vm for testing) 
## check if confluence services is running, 
## if not running, sendmail to wonops 


## VARIABLES ## 
ROOT_UID=0
E_NONROOT=87
VM=192.168.*.*
LOGFILE=/home/mcbeeff/alertlog.txt
email=email
passwd=somepassword

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
	
	date; echo  "Status : $VM is up " >> $LOGFILE; echo 
	ssh -i ~/.ssh/server1 root@$VM 	'echo test'
					 ## change variable to conflunce server when ready			
				 	 ## TODO :: 
 	#systemctl status 		 ## determine best way to confirm confluence services is runniing 
			 		 ## Check java services, confluence/status url links, etc
					 ## Check if proper ports are open, tomcat service is running, confluence user
					 ## is running



}

remote_server(){
	let email=$(echo "Checking confluence services.."; echo)
	let bool=$(echo $?)
	if [ $bool -ne 0 ]
	then
		PYTHON_ARG="$1" python3 - <<END
		import smtplib
		user=email
		passwd=somepassword
		smtpObj = smtp.SMT_SSL(smtp.gmail.com, 465 )
		smtpObj.ehlo
		smtpObj.starttls()
		smtpObj.login(user, passwd)
		smtpObj.sendmail(user, 'jffrystwrt@gmail.com' , 'PYTHON_ARG')

END
	fi

}



remote_init

exit 0; 
