int sensorPosPin = A2;
int rawPos;
int t;
int inByte;
bool mod;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(sensorPosPin, INPUT);
  t = 0;
}

void loop() {
  // put your main code here, to run repeatedly:
  inByte = Serial.read();
  if (inByte == '1')
    mod = true;
  else if (inByte == '2')
    mod = false;

  if (mod)
    rawPos = analogRead(sensorPosPin);
  else{
    t++;
    rawPos = 512 + 512.0 * sin (0.1 * t);
    
  }
  Serial.println(rawPos);
  
  delay(10);
}
