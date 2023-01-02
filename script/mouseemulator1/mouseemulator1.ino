/* Mouse Emulator
This sends either Pot 1 and Pot 2 to serial port
or the magnetometer x1 and x2 
*/
 
/*Example: An LSM303DLH gives an accelerometer Z axis reading of -16144
with its default full scale setting of +/- 2 g. Dropping the lowest 4
bits gives a 12-bit raw value of -1009. The LA_So specification in the
LSM303DLH datasheet (page 11) states a conversion factor of 1 mg/digit
at this FS setting, so the value of -1009 corresponds to -1009 * 1 =
1009 mg = 1.009 g.
*/

#include <Wire.h>
#include <LSM303.h>

LSM303 compass;


long Pot1;
long Pot2;
long valx[40];
long valy[40];


// The setup routine runs once when you press reset:
void setup() {
  // Initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  Wire.begin();
  compass.init();
  compass.enableDefault();
}

// The loop routine runs over and over again forever:
void loop() {
  long avx = 0;
  long avy = 0;
  //Uncomment these if you want to use the compass to control the mouse
  compass.read();
  
  for(int i=0;i<39;i++){
    valx[i] = valx[i+1];
  }
  valx[39] = compass.a.x;

  for(int i=0;i<39;i++){
    valy[i] = valy[i+1];
  }
  valy[39] = compass.a.y;

  for(int i=0;i<40;i++){
    avx = avx + valx[i];
    avy = avy + valy[i];
  }
  Serial.print(avx / 40);
  Serial.print(" ");
  Serial.println(avy / 40);
  
  
}
