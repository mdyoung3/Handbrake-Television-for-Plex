#/bin/bash

EP="_s"
SE="_e"

echo "Starting script";

echo "What is the name of the show?"
read show_name

echo "What season is it?"
read season

echo "What is the first episode on the disc"
read EPISODE

for i in 1 2 3 4 
do
#echo "This is the number $i in the loop"

HandBrakeCLI -t $i -i /dev/sr0 -o "$show_name$EP$season$SE$EPISODE.mkv" -s 1 q 1 
((EPISODE++))
#echo $EPISODE
done

echo "Done."
