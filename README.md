# ConvertRecTV
***
## A powershell script to search for MPEG-TS (or anything) video files and convert ten to h265/MP4.

Like many, I have a Plex server for managing videos. I have a HD Home Run for viewing broadcast television on my smart devices. I also use a Plexpass to manage DVR on plex, including recording the shows I want (usually this is documentary or kids shows on PBS). Unfortunately, Plex saves these files as nearly uncompressed MPEG2 Transport Streams, which take up a load of room (but store fast).

My NAS has 50TB of storage, of which a solid 1.1TB is currently occupied by recorded TV shows. I didn't want ot have to use handbrake to convert them all, and try and find them, so I (with the help of OpenAI) wrote up this script in powershell. You can select a root folder where you recorded media is, and it will search all folders for .ts files and convert them to h.265, and move the files into a 'converted' folder in the root.

For example:

`Media\Television\Some TV Show\Season 01\Episode 1.ts``

The output will be:

`Media\Television\converted\Some Tv Show\Season 01\Episode 1.mp4``

You can just delete the folder strucrure outside of converted, and copy the contents of converted back to the root folder.

## Requirements

Able to run Powershell (you can install powershell on Mac OS and Linux, it comes built in on Windows)
The use case is you will run this on a PC with hardware acceleration and read the files off of a NAS.

Need FFMPEG installed. Update the variable at the top of the script to the ffmpeg binary location!

Right now the script expects you to have an NVIDIA GPU, since it uses ffmpeg's hevc_nvenc encoder library. I plan to update the script to support Intel, AMD, Apple Silicon, etc. hardware support.

## TODO

* Add support to auto-download ffmpeg.
* Add a basic UI
* Add option to select support for hardware acceleration for Intel/AMD/NVIDIA.
* Add option to select between h264/h265 encocder.
* Add option to select between MP4/MKV output.
* Add a feature to dump ffmpeg output to file and read the file to get status of job.
* Add status information about running batches.

***
    
> Open an issue if you have a question, this project is low priority while I work on an undergraduate capstone and study for Azure Developer Associate certification.