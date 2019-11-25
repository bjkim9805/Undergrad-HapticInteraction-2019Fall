import processing.serial.*;
Serial myPort;
String portName;
float val1;
float[] keep_val1;

int nSample = 200;
int t=0;
String keyDisp;
int mod;
void setup(){
  size(800, 600);
  printArray(Serial.list());
  
  int portnum = Serial.list().length - 1;
  myPort = new Serial(this, Serial.list()[portnum], 9600);
  portName = Serial.list()[portnum];
  
  keep_val1 = new float[nSample];
  val1 = 0;
  
  keyDisp = "-";
  
  mod = 1;
}
void draw(){
  background(255);
  fill(0);
  int lf = 10;
  String buf;
  buf = String.format("%s", portName);
  text(buf, 20, 30);
  
  buf = String.format("%06d, %.0f", frameCount, val1);
  text(buf, 20, 50);
  
  text(keyDisp, 20, 70);
  
  int offset_x1 = 100;
  int offset_y1 = 400;
  int y1, y2;
  float g = 0.25;
  float gx = 2.0;
  for(int i=0; i<nSample-1; i++)
  {
    y1 = int(offset_y1 - g* keep_val1[i]) - 0;
    y2 = int(offset_y1 - g* keep_val1[i+1]) - 0;
    stroke(255,0,0);
    line(offset_x1 + gx*i, y1, offset_x1 + gx*(i+1), y2);
    
  }
  //int t = 0;
  while (myPort.available() > 0) 
  {
    String str1  = myPort.readStringUntil(lf);//myPort.readString();
    
    if (str1 != null) 
    {
      val1 = float(str1);
      ShiftWithNewf(keep_val1, val1);
    }
  }
}

void keyPressed(){
  keyDisp = String.format("%c", key);
  
  myPort.write(key);
}

float GetMean(float[] arr)
{
  int sz = arr.length;
  int i;
  float sum =0;
  for(i=0; i< sz; i++)
  {
    sum = sum + arr[i];
  }
  
  float mean = sum / float(i);
  return mean;
}

void ShiftWithNewf(float[] arr, float n_val)
{
  int sz = arr.length;
  int i;
  for(i=0; i< sz-1; i++)
  {
    arr[sz-1-i] = arr[sz-2-i];
    
  }

  arr[0] = n_val;

}
