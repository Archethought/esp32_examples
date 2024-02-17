#include <Arduino.h>
#include <WiFi.h>
#include <HTTPClient.h>

// Replace with your network credentials
const char *ssid = "your_wifi";
const char *password = "your_pass";
String     hostname = "http://ifconfig.me";

unsigned long lastTime = 0;
// Timer set to 10 minutes (600000)
//unsigned long timerDelay = 600000;
// Set timer to 5 seconds (5000)
unsigned long timerDelay = 30000;
unsigned long connectDelay = 5000;

void setup() {
  // Start Serial Monitor
  Serial.begin(115200);
  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  // Connected to Wi-Fi
  delay(connectDelay);
  Serial.print("Connected to WiFi: ");
  Serial.println(WiFi.localIP());
}
void loop() {
  //Send an HTTP POST request every 10 minutes
  if ((millis() - lastTime) > timerDelay) {
    //Check WiFi connection status
    if(WiFi.status()== WL_CONNECTED){
      HTTPClient http;

      String serverPath = hostname;
      
      // Your Domain name with URL path or IP address with path
      http.begin(hostname.c_str());
      
      // Send HTTP GET request
      int httpResponseCode = http.GET();
      
      if (httpResponseCode>0) {
        Serial.print("HTTP Response code: ");
        Serial.println(httpResponseCode);
        String payload = http.getString();
        Serial.println(payload);
      }
      else {
        Serial.print("Error code: ");
        Serial.println(httpResponseCode);
      }
      // Free resources
      http.end();
    }
    else {
      Serial.println("WiFi Disconnected");
    }
    lastTime = millis();
  }
} 
