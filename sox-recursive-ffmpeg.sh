#!/bin/bash

# A simple script to recursively resample a bunch of files
# in a directory. Only certain file extensions (mp3, aac,
# flac, wav) are considered.
#
# It takes 3 command line options: `indir`, `outdir`, and SOX_OPTS.
# The destination (`outdir`) is relative to the current
# directory of where you were when the script was run.
# option 3 is the target sample rate (ie 44100)
#
# Always converts to 16bit.
#
# Example: sox-recursive-convert.sh 48kSamples/ 44kSamples/ 44100
#
# The direcotry structure inside `indir` will be replicated
# in `outdir`.


# Sourece directory with files to convert
InDir=$1

# Set the directory you want for the converted files
OutDir=$2

# make sure the output directory exists (create it if not)
mkdir -p "$OutDir"

# Target output format (defaults to wav)
OutFormat=${3:-"flac"}

# Convert each file with SoX, and write the converted file
# to the corresponding output dir, preserving the internal
# structure of the input dir
find -E "$InDir" -type f -iregex '.*\.(mp3|wav|flac|aac|m4a)$' -print0 | while read -d $'\0' input
do
  echo "processing" $input "with" $SOX_OPTS

  # the output path, without the InDir prefix
  output=${input#$InDir}
  # replace the original extension with OutFormat (or default to .wav)
  output=$OutDir${output%.*}.$OutFormat

  # get the output directory, and create it if necessary
  outdir=$(dirname "${output}")
  mkdir -p "$outdir"

  # finally, convert the file
  ffmpeg -nostdin -i "$input" -y "$output"

#  echo $input
#  echo $output
#  echo "ffmpeg -i \"$input\" -y \"$output\""

  echo "saved as $output"
done
