#!/bin/bash

# Convert all MKV files in your OBS recordings folder to MP4
RECORDINGS_DIR="$HOME/Videos/obs-recordings"

for file in "$RECORDINGS_DIR"/*.mkv; do
  [ -e "$file" ] || continue
  mp4file="${file%.mkv}.mp4"
  ffmpeg -i "$file" -c copy "$mp4file"
  echo "Converted $file to $mp4file"
done

# Usage:

# Save the script as convert-mkv-to-mp4.sh in your LMS folder.
# Make it executable:

# chmod +x LMS/convert-mkv-to-mp4.sh
# Run it after recording:

# ./LMS/convert-mkv-to-mp4.sh
# Tip for README:

# Record in MKV for safety.
# Use the conversion script before uploading to Moodle or YouTube.
# Always edit your videos for intros/outros and polish!
# You didn’t break OBS—this workflow is recommended by many creators.