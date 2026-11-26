#!/bin/zsh
# Short looping bug clips for the site, from the film's HD frame dirs (one frame = 0.02 s sim time).
# Played at 25 fps = 2x slower than real time. 960x720, no audio.
set -e; F=~/simuguard-film/film/f; cd ${0:a:h}
clip(){ # name dir start nframes
  ffmpeg -y -loglevel error -framerate 25 -start_number $3 -i $F/$2/%03d.jpg -frames:v $4 \
    -vf scale=960:720 -c:v libx264 -preset slow -crf 25 -pix_fmt yuv420p -an -movflags +faststart $1.mp4
  ffmpeg -y -loglevel error -i $1.mp4 -vf "select=eq(n\,$5)" -frames:v 1 -q:v 4 $1.jpg
  echo "$1 $(du -h $1.mp4 | cut -f1)"; }
clip bug_robotwin hero_hd 64 160 70
clip bug_libero   hd_libero_mug_microwave_ep05 40 141 30
[ -d $F/hd_dojo_tubes_L2_s0_crop ] && clip bug_robodojo hd_dojo_tubes_L2_s0_crop 40 141 30 || echo "robodojo: frames not ready"
