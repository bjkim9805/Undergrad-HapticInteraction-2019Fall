import processing.serial.*;
Serial myPort;

float val1;
void setup(){
  size(800, 600);
  printArray(Serial.list());
  
  myPort = new Serial(this, Serial.list()[Serial.list().length - 1], 9600);
  
  val1 = 0;
}

void draw() {
  background(255);
  fill(0);
  int lf = 10;
  
  String buf = String.format("%06d, %.0f", frameCount, val1);
  text(buf, 20, 50);
  
  while(myPort.available() > 0){
    String str1 = myPort.readStringUntil(lf);
    if(str1 != null){
      val1 = float(str1);
    }
  }
}
