This is a repository for various batch-processing scripts I have written for audio files.

soxbatch2 usage:
./soxbatch2 "search pattern" "file format" "format options" "name addendum" "extra arguments" "run flag"

example:
./soxbatch2 "*.wav" "wav" "" "-processed" "trim 0 0:02 fade 0 0 0.1 norm" 1

that will look in a directory for all files ending in .wav ("*.wav"), and for each,
output a new wav file ("wav")
named FILENAME-processed.wav ("-processed"), 
trimmed to 2 seconds ("trim 0 0:02"), 
with a 0.1 second fadeout ("fade 0 0 0.1"), 
and normalised ("norm").
the '1' at the end is the flag that actually runs the script, without it, it will just print out 
the sox command.

recursive usage:
this one you can leave out the last argument, OR you can pass in your own sox options... 

simplest usage (44.1k, 16bit default):
bash ./sox-recursive-convert.sh sourceDir targetDir

advanced usage (mono, 22.5k, 8 bit):
bash ./sox-recursive-convert.sh sourceDir targetDir "-c 1 -b 8 -r 22050" 

