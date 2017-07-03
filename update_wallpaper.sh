#!/bin/sh

set -e

DATE="$(date +'%Y.%m.%d')"

cd /opt/wanikaniwallpaper
pwd

./wanikaniwallpaper \
	-k "${WK_APIKEY}" \
	--margin-left=30 \
	--margin-right=30 \
	--margin-top=30 \
	--margin-bottom=50 \
	--out="/tmp/${DATE}.png"

aws s3 cp --acl public-read "/tmp/${DATE}.png" "s3://${S3_BUCKET}/wk_wallpaper/${DATE}.png"

mkdir -p ./localcache/
aws s3 sync "s3://${S3_BUCKET}/wk_wallpaper/" ./localcache/
convert -delay 45 -loop 0 -geometry 1280x720 ./localcache/*.png progress.gif
aws s3 cp --acl public-read "progress.gif" "s3://${S3_BUCKET}/"
