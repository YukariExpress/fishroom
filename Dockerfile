FROM python:3.5-alpine

COPY fishroom /fishroom
COPY requirements.txt /fishroom

RUN apk add --update\
	build-base\
	libjpeg-turbo-dev\
	libjpeg-turbo\
	libmagic\
	libpng-dev\
	libpng\
	libwebp-dev\
	libwebp\
	shared-mime-info\
	tzdata\
	zlib-dev\
	zlib

RUN python3 -m ensurepip &&\
	pip3 install -U pip setuptools &&\
	pip3 install -r /fishroom/requirements.txt

RUN apk del build-base\
	libjpeg-turbo-dev\
	libpng-dev\
	libwebp-dev\
	zlib-dev

WORKDIR /

CMD [ "sh", "-c", "python -m fishroom.${FISHROOM_MODE}" ]
