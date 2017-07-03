#/bin/bash

APIKEY="911a778032571b6e0e3b66af2cfe919b"
DATE="$(date +'%Y.%m.%d')"
BUCKET=nihongo.justinian.io

cd /home/justin/wanikaniwallpaper

./wanikaniwallpaper \
	-k "${APIKEY}" \
	--font=font/ipag.ttf \
	--margin-left=30 \
	--margin-right=30 \
	--margin-top=30 \
	--margin-bottom=50 \
	--out="./localcache/${DATE}.png"

optipng -clobber -quiet "./localcache/${DATE}.png"
aws s3 cp --quiet --acl public-read "./localcache/${DATE}.png" "s3://${BUCKET}/wk_wallpaper/${DATE}.png"

aws s3 sync "s3://${BUCKET}/wk_wallpaper/" ./localcache/
convert -delay 45 -loop 0 -geometry 1280x720 ./localcache/*.png progress.gif
aws s3 cp --quiet --acl public-read "progress.gif" "s3://${BUCKET}/"
