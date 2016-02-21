#/bin/bash

EP="_s"
SE="_e"

echo "Starting script";

echo "What is the name of the show?"
read show_name

echo "What season is it?"
read season

echo "What is the first episode of the disc?"
read episode

HandBrakeCLI -t 1 -i /dev/sr0 -o "$show_name$EP$season$SE$episode.mp4" -s 1 q 1 
((episode++))

HandBrakeCLI -t 2 -i /dev/sr0 -o "$show_name$EP$season$SE$episode.mp4" -s 1 q 1
((episode++))

HandBrakeCLI -t 3 -i /dev/sr0 -o "$show_name$EP$season$SE$episode.mp4" -s 1 q 1
((episode++))

HandBrakeCLI -t 4 -i /dev/sr0 -o "$show_name$EP$season$SE$episode.mp4" -s 1 q 1
((episode++))

HandBrakeCLI -t 5 -i /dev/sr0 -o "$show_name$EP$season$SE$episode.mp4" -s 1 q 1
((episode++))

HandBrakeCLI -t 6 -i /dev/sr0 -o "$show_name$EP$season$SE$episode.mp4" -s 1 q 1
((episode++))

HandBrakeCLI -t 7 -i /dev/sr0 -o "$show_name$EP$season$SE$episode.mp4" -s 1 q 1

echo "Done."
