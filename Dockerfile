FROM alpine:3.2
MAINTAINER Justin C. Miller <justin@devjustinian.com>

# Install awscli and ImageMagick
RUN \
	apk -Uuv add groff less python py-pip imagemagick && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

ADD ./order /opt/wanikaniwallpaper/
ADD ./font/ipag.ttf /opt/wanikaniwallpaper/
ADD ./wanikaniwallpaper /opt/wanikaniwallpaper/
ADD ./update_wallpaper.sh /etc/periodic/daily/update_wallpaper.sh

CMD ["crond", "-f", "-d", "8"]
