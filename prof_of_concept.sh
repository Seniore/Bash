oldIFS="$IFS"
IFS=$'\n'
max_proc=2
for server in `cat lista.txt`; do
        echo "testing $server"
        eval $server &
        sleep 2
        counter=`pgrep -lf max | wc -l`
        echo "current counter $counter"
        until [ "$max_proc" -ge "$counter" ]
        do
                echo "Waiting... $counter ... $server"
                sleep 5
                counter=`pgrep -lf max | wc -l`
        done
done

#wait till the last one finishes
counter=`pgrep -lf max | wc -l`
until [ "$counter" -eq "0" ]
do
        echo "Finishing... $counter ... $server"
        sleep 5
        counter=`pgrep -lf max | wc -l`
done

echo "We are done"
IFS="$oldIFS"