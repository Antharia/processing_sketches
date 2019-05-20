import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress remote;

int nbPoints = 200;
int[] noiseCurve;
float noiseFactor = 0.0;
float step = 0.03;
float noiseStart = 0.0;

void setup() {
  size(600, 600);
  noiseCurve = new int[nbPoints];
  
  osc = new OscP5(this, 4444); // receive on port 4444
  remote = new NetAddress("127.0.0.1", 7777); // send on port 7777
}  

void draw() {
  background(240);
  stroke(40);
  noFill();
  for (int i = 0; i < nbPoints; i++) {
     noiseCurve[i] = int(map(noise(noiseFactor), 0, 1, 100, 400));
     noiseFactor += step;
  }
  beginShape();
  for (int i = 0; i < nbPoints; i++) {
    int posX = i * (width / nbPoints);
    int posY = noiseCurve[i];
    curveVertex(posX, posY);
    
  }
  noiseStart += step;
  noiseFactor = noiseStart;
  endShape();
  OscMessage m = new OscMessage("/freq");
  m.add(400-noiseCurve[nbPoints-1]);
  osc.send(m, remote);
}
