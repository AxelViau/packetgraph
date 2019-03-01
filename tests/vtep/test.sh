#!/bin/sh

grep PG_ASAN_CFLAGS ./config.mk
OUT=$?

if [ $? -eq 0 ]; then
	OPT="--base-virtaddr 0x200000000000"
elif [ $? -eq 1 ]; then
	OPT=""
else
	(>&2 echo "config.mk does not exist, assuming no adress sanitizer")
	OPT=""
fi

sudo ./tests-vtep -c1 -n1 --socket-mem 256 --no-shconf $OPT
