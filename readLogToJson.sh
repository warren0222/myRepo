#!/bin/bash
cat helpdesk_log | grep -e 'error:' -e 'error =' | cut -d ' ' -f 3-5,7- | awk -F " " '{for(i=1;i<=1;i++){if(i==1){$i=substr($i,0,2)}else{$i=$i}}; printf "%02d00-%02d00 %s\n",$1, $1+1, $0}' | cut -d ' ' -f 1,3- | sort | uniq -c > log
i=0
touch log.json
echo "[" > log.json
while read line
do
	desc[i]=$(echo $line | awk -F']' '{print $2}')
	pid[i]=$(echo $line | awk -F']' '{print $1}' | awk -F'[' '{print $2}')
	other=$(echo $line | awk -F']' '{print $1}' | awk -F'[' '{print $1}')
	num[i]=$(echo $other | awk -F' ' '{print $1}')
	deviceName[i]=$(echo $other | awk -F' ' '{print $3}')
	timeWindow[i]=$(echo $other | awk -F' ' '{print $2}')
	pName[i]=$(echo $other | awk -F' ' '{print $4}')
	#echo ${desc[i]}
	#echo ${pid[i]}
	#echo ${num[i]}
	#echo ${timeWindow[i]}
	#echo ${deviceName[i]}
	#echo ${pName[i]}
	#echo ${other[i]}
	printf '\t{\n' >> log.json
	printf "\t\t\"deviceName\":\"${deviceName[i]}\"},\n" >> log.json
	printf "\t\t\"processId\":\"${pid[i]}\"},\n" >> log.json
	printf "\t\t\"processName\":\"${pName[i]}\"},\n" >> log.json
	printf "\t\t\"description\":\"${desc[i]}\"},\n" >> log.json
	printf "\t\t\"timeWindow\":\"${timeWindow[i]}\"},\n" >> log.json
	printf "\t\t\"numberOfOccurrence\":\"${num[i]}\"}\n" >> log.json
	printf '\t}\n' >> log.json
	((i++))
done < log
echo "]" >> log.json

curl --data @log.json  https://foo.com/bar
curl -X POST -H Content-Type:application/json -d "@log.json" https://foo.com/bar
