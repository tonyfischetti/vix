# cli, ffmpeg, mp4, mp3


ffmpeg -i video.mp4 -vn -q:a 0 -map a song.mp3
#                   ignore the video stream
#                       highest quality
#                              choose all audio streams
