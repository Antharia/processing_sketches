import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress remote;

void setup() {
  size(800, 800);
  
  osc = new OscP5(this, 4444);
  remote = new NetAddress("127.0.0.1", 7777);
}

void draw() {
   background(240);
   stroke(40);
   noFill();
   
   // your code here
   
   OscMessage m = new OscMessage("/msg");
   m.add(123);
   osc.send(m, remote);
   
}
