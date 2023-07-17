#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <SoftwareSerial.h>

int TxD;
int RxD;
char data;
String message, previousMessage, x;
SoftwareSerial bluetooth(TxD, RxD);

#define screen_width 128 // OLED display width in pixels
#define screen_height 64 // OLED display height in pixels

Adafruit_SSD1306 display(screen_width, screen_height);

void setup() {
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
  Serial.begin(9600);
  bluetooth.begin(9600);
}

void loop()
{  
  if (bluetooth.available() > 0) 
  {
    message = Serial.readString();
    

    if (message != previousMessage) {
      previousMessage = message;

      display.clearDisplay();
      display.setTextSize(2);
      display.setTextColor(SSD1306_WHITE);
      display.setCursor(0, 0);
      display.print(message);
      delay(10000);
      display.display();
    }
  }
}
