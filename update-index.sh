pushd html
find data -type f -iname "*o.jpg" -o -iname "*o.mp4" | while read fn; do
        if [[ "$fn" == *.jpg ]]; then
		small=${fn%.jpg}_small.jpg
		thumb=${fn%.jpg}_thumb.jpg
		if [ ! -f "$small" ]; then
			convert "$fn" -size 4096x4096 -resize 4096x4096 "$small"
		fi
		if [ ! -f "$thumb" ]; then
			convert "$fn" -size 300x300 -resize 300x300 "$thumb"
		fi
		echo $small >> filelist.tmp.txt
	elif [[ "$fn" == *.mp4 ]]; then
		thumb=${fn%.mp4}_thumb.jpg
		webm=${fn%.mp4}.webm
		if [ ! -f "$thumb" ]; then
			ffmpeg -i "$fn" -vframes 1 -f image2 -vf scale=400:-1  "$thumb"
		fi
		if [ ! -f "$webm" ]; then
			ffmpeg -i "$fn" -c:v libvpx -b:v 1M -c:a libvorbis "$webm"
		fi
		echo $fn >> filelist.tmp.txt
	fi
done
sort < filelist.tmp.txt > filelist.txt
rm filelist.tmp.txt
popd 
