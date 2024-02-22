#!/bin/bash
. ./venv/bin/activate
# Compile and upload
arduino-cli compile --fqbn esp32:esp32:esp32 wifi --build-property build.partitions=min_spiffs --build-property upload.maximum_size=1966080
# Linux
arduino-cli upload --port /dev/ttyUSB0 --fqbn esp32:esp32:esp32 wifi
# MacOS
# arduino-cli upload --port /dev/tty.usbserial-1420 --fqbn esp32:esp32:esp32 wifi
