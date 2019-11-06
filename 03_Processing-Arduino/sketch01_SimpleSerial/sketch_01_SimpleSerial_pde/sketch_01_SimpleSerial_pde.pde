import processing.serial.*;
Serial myPort;

String keyDisp;
void setup(){
  size(800,600);
  printArray(Serial.list());
  
  myPort = new Serial(this, Serial.list()[Serial.list().length - 1], 9600);
  keyDisp = "-";
}

void draw(){
  background(255);
  fill(0);
  
  String buf = String.format("cnt : %d", frameCount);
  text(buf, 20,20);
  text(keyDisp, 20,40);
}
void keyPressed() {
  keyDisp = String.format("%c",key);
  myPort.write(key);
}
