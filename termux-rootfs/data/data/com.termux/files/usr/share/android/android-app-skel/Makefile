##
##  Example makefile for Android application
##

KEYSTORE = /data/data/com.termux/files/usr/etc/debug.jks

all: compile package sign

compile:
	mkdir -p ./output
	aapt package -v -m -f -J ./output -M ./AndroidManifest.xml -S ./res
	jack --output-dex ./output --import-resource ./res ./src ./output

package:
	aapt package -v -f -M ./AndroidManifest.xml -S ./res -F ./app-unsigned.apk
	aapt add -f -k ./app-unsigned.apk ./output/classes.dex

sign:
	apksigner $(KEYSTORE) ./app-unsigned.apk ./app-signed.apk

clean:
	rm -rf ./output/*
	rm -f *.apk
