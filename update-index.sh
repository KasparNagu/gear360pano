pushd html
find data -type f -iname "*o.jpg" | while read fn; do
	small=${fn%.jpg}_small.jpg
	if [ ! -f "$small" ]; then
		convert "$fn" -size 4096x4096 -resize 4096x4096 "$small";
		convert "$fn" -size 300x300 -resize 300x300 "${fn%.jpg}_thumb.jpg";
	fi
	echo $small
done | sort > filelist.txt
popd 
