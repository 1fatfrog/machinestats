#!/bin/bash
#Gather system stats
#Most commands use the "simplest" format to output data to another process or file easily

date;

#System Uptime and Logins 
echo "uptime:"
    uptime
echo "Currently connected:"
    w
echo "--------------------"
echo "Last logins:"
    last -a |head -3
echo "--------------------"

#Disk usage
echo "Disk and memory stats:"
    df -h | xargs | awk '{print "Total/Free disk: " $9 " - " $11}'
    free -m | xargs | awk '{print "Total/Free mem: " $8 " / " $17 " MB"}'
echo "--------------------"

#Processes and resource usage 
#runs top in batch mode for output and show most resource intense processes 
echo "Processes and Resources:"
    top -b |head -3
echo
    top -b |head -10 |tail -4
    echo "--------------------"

#Check your open ports and network connections
echo "Are these ports supposed to be open?:"
    nmap -p- -T4 127.0.0.1
echo "--------------------"
echo "Currenly opened connections:"
    ss -s
    echo "--------------------"

 #Logging
    start_log=`head -1 /var/log/syslog |cut -c 1-12`
    oom=`grep -ci kill /var/log/syslog`
    echo -n "Errors since $start_log :" $oom
    echo ""
    echo "--------------------" 

