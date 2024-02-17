#include <BLEAdvertisedDevice.h>
#include <BLEDevice.h>
#include <BLEScan.h>

const int PIN = 2;
const int CUTOFF = -60;

void setup() {
  Serial.begin(115200);
  delay(5000);
  Serial.println("Setup...");
  pinMode(PIN, OUTPUT);
  Serial.println("PIN set");
  BLEDevice::init("");
  Serial.println("BLE set");
  digitalWrite(PIN, HIGH);
}

void loop() {
  delay(250);
  Serial.println("Loop...");
  BLEScan *scan = BLEDevice::getScan();
  scan->setActiveScan(true);
  BLEScanResults results = scan->start(1);
  int best = CUTOFF;
  for (int i = 0; i < results.getCount(); i++) {
    BLEAdvertisedDevice device = results.getDevice(i);
    int rssi = device.getRSSI();
    if (rssi > best) {
      best = rssi;
    }
  }
  digitalWrite(PIN, best > CUTOFF ? HIGH : LOW);
  Serial.println("BEST: ", best);
}
