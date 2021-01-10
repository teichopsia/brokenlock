#built against:
#Version: ImageMagick 6.9.7-4 Q16 x86_64 20170114 http://www.imagemagick.org
#ubuntu 18.04.05
#@kehlarn

all: merge.png

clean:
	rm -f *.png #lock.png merge.png zigzag.png mask.png

biglock.png:
	curl -so biglock.png https://i.stack.imgur.com/dos7W.png

lock.png: biglock.png
	convert -scale 120x120 $< $@

zigzag.png:
	convert -size 120x120 xc:none -background none -stroke black \
    -strokewidth 5 -draw "line 69,05 54,20" \
    -strokewidth 5 -draw "line 54,17 69,30" \
    -strokewidth 5 -draw "line 69,27 54,40" \
    -strokewidth 5 -draw "line 54,37 69,50" \
    -strokewidth 5 -draw "line 69,47 54,60" \
    -strokewidth 5 -draw "line 54,57 69,70" \
    -strokewidth 5 -draw "line 69,67 54,80" \
    -strokewidth 5 -draw "line 54,77 69,90" \
    -strokewidth 5 -draw "line 69,87 54,100" \
    -strokewidth 5 -draw "line 54,97 69,110" $@

mask.png: zigzag.png
	convert $< -alpha extract -negate $@

merge.png: lock.png mask.png
	convert lock.png mask.png \
    \( -clone 0 -alpha extract \) \
    \( -clone 1,2 -compose multiply -composite -gravity center \) \
    -delete 1,2 -compose over -compose copy_opacity -composite $@
