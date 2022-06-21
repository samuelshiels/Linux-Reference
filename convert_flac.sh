#!/bin/bash
#A script to convert all the .flac file in a directory into .mp3 files
#Uses parallel, ffmpeg and libmp3lame to convert, copy tags and speed up
#Stores results in folder convertflac

###TODO
#parameterise?
###
rmdir convertflac
mkdir convertflac

parallel ffmpeg -i {} -acodec libmp3lame -ab 320k convertflac/{.}.mp3 ::: *.flac
