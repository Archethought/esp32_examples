# Build Automation
Modern software development requires extensive automation in order to increase productivity, reduce errors, costs and manage schedule.
A typical software development step will be to push code change to a repository, and have an automated process detect changes and start build and deployment.

This project automates the build of all of the modules, include ESP32, Flutter App and Web System.

## ESP32
The command line program to build ESP32 code is `arduino-cli`. This program also deploys to the ESP32 chip. 

Example compile, upload and monitor:

```
# Compile and upload
arduino-cli compile --fqbn esp32:esp32:esp32 esp32_project_ino_directory_name --build-property build.partitions=min_spiffs,upload.maximum_size=1966080
arduino-cli upload --port /dev/ttyUSB0 --fqbn esp32:esp32:esp32 esp32_project_ino_directory_name
# To monitor the serial port using screen (tested on Mac OS X and Ubuntu Linux) wait until upload completes
# screen /dev/cu.usbserial-1410 115200
screen /dev/ttyUSB0 115200
```

Learn more about how the arduino-cli sees the world:

```
arduino-cli compile –fqbn esp32:esp32:esp32 –show-properties
```

When using `--build-property` you are asking arduino-cli to pass the following parameters into the compile. You may use more than one of these.

In the case of `min_spiffs` this is a .CSV file found in the Arduino Library where Arduino is installed, namely:

```
./packages/esp32/hardware/esp32/1.0.6/tools/partitions/min_spiffs.csv
```

## Flutter
The main approach is github actions deployed to the Google Play Store..

This section needs more research.

## Web System
The main approach is github actions, deployed to either docker-compose or kubernetes.

This section needs more research.
