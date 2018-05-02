#include "SevSeg.h"
SevSeg sevseg; //Instantiate a seven segment controller object

void setup() {
  byte numDigits = 4;
  byte digitPins[] = {5, 4, 3, 2};
  byte segmentPins[] = {8, 9, 10, 11, 12, 13, 14, 15};
  bool resistorsOnSegments = false; // 'false' means resistors are on digit pins
  byte hardwareConfig = COMMON_CATHODE; // See README.md for options
  bool updateWithDelays = false; // Default. Recommended
  bool leadingZeros = false; // Use 'true' if you'd like to keep the leading zeros
  
  sevseg.begin(hardwareConfig, numDigits, digitPins, segmentPins, resistorsOnSegments, updateWithDelays, leadingZeros);
  sevseg.setBrightness(90);
}

void loop() {
  static unsigned long timer = millis();
  static int deciSeconds = 0;
  sevseg.setNumber(deciSeconds,3);
  
  if (millis() - timer >= 300) {
    
    timer += 100;
    if(deciSeconds%100==59)
    {
       deciSeconds+=41;
    }
    else 
     deciSeconds++; // 100 milliSeconds is equal to 1 deciSecond
    
    if (deciSeconds == 2359) { // Reset to 0 after counting for 1000 seconds.
      deciSeconds=0;
    }
    sevseg.setNumber(deciSeconds, 1);
  }

  sevseg.refreshDisplay(); // Must run repeatedly
}
