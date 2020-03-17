curl -G 'http://localhost:8086/query?db=domoticz' --data-urlencode "q=SELECT * FROM Temperature WHERE \"name\"='Szafka' AND value>100" | jq -r "(.results[0].series[0].values[][0])" > delete_timestamps.txt

for i in $(cat delete_timestamps.txt); do
	echo $I;
	curl -G 'http://localhost:8086/query?db=domoticz' --data-urlencode "q=DELETE FROM Temperature WHERE time='$i'"; 
done
