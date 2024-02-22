#!/bin/bash
. ./venv/bin/activate
# Compile and upload
arduino-cli compile --fqbn esp32:esp32:esp32 red_blue_web --build-property build.partitions=min_spiffs --build-property upload.maximum_size=1966100
arduino-cli upload --port /dev/ttyUSB0 --fqbn esp32:esp32:esp32 red_blue_web
