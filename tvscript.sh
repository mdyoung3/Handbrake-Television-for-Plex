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

HandBrakeCLI -t 1 -i /dev/sr0 -o "$show_name$EP$season$SE$episode".mkv -E lame -B 160k -6 stereo -R 48000 -e x264 -x b_adapt=2:bframes=8:direct=auto:fast_pskip=0:deblock=-1,-1:psy-rd=1,0.15:me=umh:me_range=24:partitions=all:ref=16:subq=10:trellis=2:rc_lookahead=60:frameref=15:threads=auto -s1 -2 -v2
((episode++))

HandBrakeCLI -t 2 -i /dev/sr0 -o "$show_name$EP$season$SE$episode".mkv -E lame -B 160k -6 stereo -R 48000 -e x264 -x b_adapt=2:bframes=8:direct=auto:fast_pskip=0:deblock=-1,-1:psy-rd=1,0.15:me=umh:me_range=24:partitions=all:ref=16:subq=10:trellis=2:rc_lookahead=60:frameref=15:threads=auto -s1 -2 -v2
((episode++))

HandBrakeCLI -t 3 -i /dev/sr0 -o "$show_name$EP$season$SE$episode".mkv -E lame -B 160k -6 stereo -R 48000 -e x264 -x b_adapt=2:bframes=8:direct=auto:fast_pskip=0:deblock=-1,-1:psy-rd=1,0.15:me=umh:me_range=24:partitions=all:ref=16:subq=10:trellis=2:rc_lookahead=60:frameref=15:threads=auto -s1 -2 -v2
((episode++))

HandBrakeCLI -t 4 -i /dev/sr0 -o "$show_name$EP$season$SE$episode".mkv -E lame -B 160k -6 stereo -R 48000 -e x264 -x b_adapt=2:bframes=8:direct=auto:fast_pskip=0:deblock=-1,-1:psy-rd=1,0.15:me=umh:me_range=24:partitions=all:ref=16:subq=10:trellis=2:rc_lookahead=60:frameref=15:threads=auto -s1 -2 -v2
((episode++))

HandBrakeCLI -t 5 -i /dev/sr0 -o "$show_name$EP$season$SE$episode".mkv -E lame -B 160k -6 stereo -R 48000 -e x264 -x b_adapt=2:bframes=8:direct=auto:fast_pskip=0:deblock=-1,-1:psy-rd=1,0.15:me=umh:me_range=24:partitions=all:ref=16:subq=10:trellis=2:rc_lookahead=60:frameref=15:threads=auto -s1 -2 -v2
((episode++))

HandBrakeCLI -t 6 -i /dev/sr0 -o "$show_name$EP$season$SE$episode".mkv -E lame -B 160k -6 stereo -R 48000 -e x264 -x b_adapt=2:bframes=8:direct=auto:fast_pskip=0:deblock=-1,-1:psy-rd=1,0.15:me=umh:me_range=24:partitions=all:ref=16:subq=10:trellis=2:rc_lookahead=60:frameref=15:threads=auto -s1 -2 -v2
((episode++))

echo "Done."
