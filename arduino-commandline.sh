#!/bin/bash
# We use jq to interpret JSON paths, make sure it is installed. For ubuntu linux
sudo apt install jq

# For macos
# brew install jq

# Download and install the latest version of the Arduino command line
cd /var/tmp
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=/usr/local/bin sh
arduino-cli version

# Initialize the Arduino command line environment
arduino-cli config init
arduino-cli core update-index

#####
# IMPORTANT: the --zip-path will not run unless 'unsafe' is True in the configuration file
#            use this environment variable for the run of this file only
export ARDUINO_LIBRARY_ENABLE_UNSAFE_INSTALL=true

#####
# Add the following lines to the recently created arduino-cli.yaml configuration, as additional_urls
#     https://arduino.github.io/arduino-cli/0.20/configuration/#configuration-file
# The directory where arduino-cli.yaml is located is $HIDDEN_DIR
HIDDEN_DIR=$(arduino-cli config dump --format json | jq [.directories.data][0] | tr -d '"')
cat << EOF >> $HIDDEN_DIR/arduino-cli.yaml
board_manager:
  additional_urls:
    - https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
EOF
#####
# Enable Third Party libraries
sed -i 's/  enable_unsafe_install: false/  enable_unsafe_install: true/g' $HIDDEN_DIR/arduino-cli.yaml

#####
# Reach out to the Internet based libraries for install and/or update
arduino-cli core update-index
arduino-cli core install esp32:esp32

#####
# Prove the esp32 boards are now listed
arduino-cli board listall

#####
# Install (example) libraries for your program (use what is unique to your project!)
arduino-cli lib install "Adafruit PWM Servo Driver Library"
arduino-cli lib install "Adafruit SSD1306"
arduino-cli lib install "Adafruit Neopixel"
arduino-cli lib install "Adafruit BME280"
arduino-cli lib install "ArduinoJson"
arduino-cli lib install "FreeRTOS"

# TODO: See if the following ZIP files can be imported directly from HTTP URI
# There is a way to use git urls, so we can try this:
#    arduino-cli lib install --git-url https://github.com/arduino-libraries/WiFi101.git
#
# Source repo: https://github.com/me-no-dev/AsyncTCP
# ZIP for above: https://github.com/me-no-dev/AsyncTCP/archive/master.zip

#####
# Source repo: https://github.com/me-no-dev/ESPAsyncWebServer
# ZIP for above: https://github.com/me-no-dev/ESPAsyncWebServer/archive/master.zip
arduino-cli lib install --zip-path ./Third_Party_Libraries/AsyncTCP-master.zip
arduino-cli lib install --zip-path ./Third_Party_Libraries/ESPAsyncWebServer-master.zip

#####
# The espressif esptool.py needs libraries, set up a Python virtualenv to give it all the latest
python3 -m venv venv

#####
# Activate the virtualenv
. ./venv/bin/activate

#####
# To stop using python virutalenv use:
# deactivate

#####
# Install to the virtualenv
pip install -U pip
pip install pyserial

# Example Compile and Run.

#####
# Compile and upload, use at the directory level of the directory `wifi_manager` - the command will look into the directory for file of same name.
# arduino-cli compile --fqbn esp32:esp32:esp32 wifi_manager --build-property build.partitions=min_spiffs --build-property upload.maximum_size=1966080
# arduino-cli upload --port /dev/ttyUSB0 --fqbn esp32:esp32:esp32 wifi_manager

#####
# To monitor the serial port using screen (tested on Mac OS X and Ubuntu Linux), wait until upload is complete
# screen /dev/cu.usbserial-1410 115200 # MacOS
# screen /dev/ttyUSB0 115200           # Linux
