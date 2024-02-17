# ESP32 Storage and WiFi

## SPIFFS

### Install using IDE
https://randomnerdtutorials.com/install-esp32-filesystem-uploader-arduino-ide/

1. Go to the [releases page and click the ESP32FS-1.0.zip]https://github.com/me-no-dev/arduino-esp32fs-plugin/releases/() file to download
1. Go to the Arduino IDE directory, and open the Tools folder.
1. Unzip the downloaded .zip folder to the Tools folder. You should have a similar folder structure:
    ```
    <home_dir>/Arduino-<version>/tools/ESP32FS/tool/esp32fs.jar
    ```
1. Finally, restart your Arduino IDE.

### Install using arduino-cli

The arduino-cli has to create the partitions. The following is the basic idea:

```
arduino-cli compile --fqbn esp32:esp32:esp32 tank.ino --build-properties build.partitions=minspiffs,upload.maximum_size=1966080
arduino-cli upload --port /dev/ttyUSB0 --fqbn esp32:esp32:esp32 Main_Project
```
In order to monitor the output from the ESP32 over the /dev/ttyXXX, the upload must complete so the USB port is not busy. On Linux, one way
to view the output is by using the `screen` command.

```
screen /dev/ttyUSB0 115200
```

To quit the `screen` command, use the key sequence:
```
CTRL-A K
```
Then `y` when prompted for Yes/No to kill the session.


### Test Code for SPIFFS
```
#include "SPIFFS.h"
 
void setup() {
  Serial.begin(115200);
  
  if(!SPIFFS.begin(true)){
    Serial.println("An Error has occurred while mounting SPIFFS");
    return;
  }
  
  File file = SPIFFS.open("/test_example.txt");
  if(!file){
    Serial.println("Failed to open file for reading");
    return;
  }
  
  Serial.println("File Content:");
  while(file.available()){
    Serial.write(file.read());
  }
  file.close();
}
 
void loop() {

}
```

## ESP32 (Async) WiFi Manager
## Source
[Random Nerd Tutorials](https://randomnerdtutorials.com/esp32-wi-fi-manager-asyncwebserver/)  
[Install ESP32 Filesystem Uploader in Arduino IDE](https://randomnerdtutorials.com/install-esp32-filesystem-uploader-arduino-ide/)

## Purpose
One time configuration of WiFi from Factory Reset Mode to operate on Test Center Network

## Libraries (N.B. Check for the latest versions when downloading)
* [AsyncTCP-master.zip](https://github.com/me-no-dev/AsyncTCP)
* [ESPAsyncWebServer-master.zip](https://github.com/me-no-dev/ESPAsyncWebServer)
* [ESP32FS-1.0.zip](https://github.com/me-no-dev/arduino-esp32fs-plugin/releases/download/1.0/ESP32FS-1.0.zip)
* [ESP32_WiFi_Manager.zip](https://github.com/RuiSantosdotme/Random-Nerd-Tutorials/raw/master/Projects/ESP32/ESP32_WiFi_Manager/ESP32_WiFi_Manager.zip)

## Project Setup
1. Unzip the ESP32_WiFi_Manager.zip file into a location where Arduino IDE will access it. This will also unpack and place all the files in the directory "data" that are needed.
1. Start the Arduino IDE and open the .ino file you just unpacked.
1. Install the libraries by using the Arduino IDE `Sketch > Include Library > Add .zip Library` and select
    * AsyncTCP-master.zip
    * ESPAsyncWebServer-master.zip
1. Install the ESP32 Filesystem Uploader plugin
    * Move the file ESP32FS-1.0.zip to the tools directory of the Arduino IDE, e.g. you_home_dir/Arduino-version/tools
    * Unzip ESP32FS-1.0.zip and you should see a structure like this: ./ESP32FS/tool/esp32fs.jar
    * Restart the Arduino IDE

## Files 
N.B. When the project was unzipped, a directory "data" was created with the web files in it. This directory "data" must be located in the directory with the code. Again the files are:
* index.html
* wifimanager.html
* style.css

`These files should not be moved from the location with the .ino program file.` They will be found there later in the step to upload them to the SPIFFS file system on the ESP32.

## Uploading Web Files
Loading the Web Files to the Filesystem on the ESP32 is a discrete step. Using the Arduino IDE execute the upload through the menu `Tools > ESP32 Sketch Data`
