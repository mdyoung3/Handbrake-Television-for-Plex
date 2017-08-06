#!/bin/bash
# 
# Copyright (c) 2017 Marc Young
#
# encode for playback on Roku or Chromcast
#
#This script takes the titles in a DVD and rips them as individual files
#

IAM=$(whoami)
INFO_SRC="/media/$IAM"
DVD_NAME=$(ls $INFO_SRC)
VOB=$INFO_SRC/$DVD_NAME/VIDEO_TS/VIDEO_TS.VOB
INPUT=/dev/sr0 

handbrake="HandBrakeCLI"
mediainfo="mediainfo"

echo $handbrake

handbrake_options="--markers --large-file --encoder x264 --encopts vbv-maxrate=25000:vbv-bufsize=31250:ratetol=inf --crop 0:0:0:0 --strict-anamorphic"

width="$(mediainfo --Inform='Video;%Width%' "$VOB")"
height="$(mediainfo --Inform='Video;%Height%' "$VOB")"

echo $width
echo $height

if (($width > 1280)) || (($height > 720)); then
    max_bitrate="5000"
elif (($width > 720)) || (($height > 576)); then
    max_bitrate="4000"
else
    max_bitrate="1800"
fi

min_bitrate="$((max_bitrate / 2))"

bitrate="$(mediainfo --Inform='Video;%BitRate%' "$input")"

if [ ! "$bitrate" ]; then
    bitrate="$(mediainfo --Inform='General;%OverallBitRate%' "$input")"
    bitrate="$(((bitrate / 10) * 9))"
fi

if [ "$bitrate" ]; then
    bitrate="$(((bitrate / 5) * 4))"
    bitrate="$((bitrate / 1000))"
    bitrate="$(((bitrate / 100) * 100))"

    if (($bitrate > $max_bitrate)); then
        bitrate="$max_bitrate"
    elif (($bitrate < $min_bitrate)); then
        bitrate="$min_bitrate"
    fi
else
    bitrate="$min_bitrate"
fi

echo $bitrate

handbrake_options="$handbrake_options --vb $bitrate"

frame_rate="$(mediainfo --Inform='Video;%FrameRate_Original%' "$VOB")"

if [ ! "$frame_rate" ]; then
    frame_rate="$(mediainfo --Inform='Video;%FrameRate%' "$VOB")"
fi 

frame_rate_file="$(basename "$VOB")"
frame_rate_file="${frame_rate_file%\.[^.]*}.txt"

if [ -f "$frame_rate_file" ]; then
    handbrake_options="$handbrake_options --rate $(cat "$frame_rate_file")"
elif [ "$frame_rate" == '29.970' ]; then
    handbrake_options="$handbrake_options --rate 23.976"
else
    handbrake_options="$handbrake_options --rate 30 --pfr"
fi

channels="$(mediainfo --Inform='Audio;%Channels%' "$VOB" | sed 's/[^0-9].*$//')"

if (($channels > 2)); then
    handbrake_options="$handbrake_options --aencoder ca_aac,copy:ac3"
elif [ "$(mediainfo --Inform='General;%Audio_Format_List%' "$VOB" | sed 's| /.*||')" == 'AAC' ]; then
    handbrake_options="$handbrake_options --aencoder copy:aac"
fi

if [ "$frame_rate" == '29.970' ]; then
    handbrake_options="$handbrake_options --detelecine"
fi

lsdvd > dvdinfo.txt

sed -i '/Disc Title:/d' dvdinfo.txt
sed -i '/Longest track:/d' dvdinfo.txt

echo "What is the name of the show?"
read show_name

if [ ! -d "$show_name" ]; then
	mkdir $show_name
fi

echo "What season is it?"
read season

echo "What is the first episode of the disc?"
read episode

echo $episode

echo "Encoding: $VOB" >&2

cat dvdinfo.txt | while read line
do
	if echo $line | grep -Eq 'Length: 00:0'
	then
    	echo 'Crap!'
	else
		echo $line
		title=$(echo $line | awk '{print $2}' | sed 's/^0*//' | tr -dc '[:alnum:]\n\r')
		output=$show_name/$show_name"_s"$season"_e"$title".mp4"
 
	    time "$handbrake" -t $title \
    		echo $handbrake_options \
    		--input "$INPUT" \
    		--output "$output" \
    		2>&1 | tee -a "${output}.log"

	fi

done

echo "Done."