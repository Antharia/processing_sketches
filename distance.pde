import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress remote;

OscMessage[] messages;

int nbNodes;
Node[] nodes;
float x, y;
float angle, radius;
float longest;
int foreground, background;

void setup() {
  size(800, 600);
  foreground = 50;
  background = 240;
  nbNodes = 12;
  nodes = new Node[nbNodes];
  angle = -PI/2;
  if (width > height) {
    radius = (height - height/5)/2;
  } else {
    radius = (width - width/5)/2;
  }
  for (int i = 0; i < nbNodes; i++) {
    x = cos(angle) * radius;
    y = sin(angle) * radius;
    nodes[i] = new Node(i, x + width/2, y + height/2);
    angle += TWO_PI / nbNodes;
  }
  longest = radius * 2 - radius / 5;
  
  // OSC SETUP
  osc = new OscP5(this, 4444);
  remote = new NetAddress("127.0.0.1", 7777);
  messages = new OscMessage[nbNodes];
}

void draw() {
  background(background);
  ellipseMode(CENTER);
  noCursor();
  for (int i = 0; i < nbNodes; i++) {
    noStroke();
    nodes[i].display();
    stroke(foreground);
    line(nodes[i].x, nodes[i].y, mouseX, mouseY);

    fill(foreground);
    rect(10, i*10+10, map(nodes[i].value, 0, longest, 0, 50), 5);
    textSize(8);
    float gui_value = round(map(nodes[i].value, 0, longest, 0, 1000));
    gui_value /= 10;
    text(gui_value + "%", 63, i*10+16);
    
    // OSC
    messages[i] = new OscMessage("/node" + i);
    messages[i].add(norm(nodes[i].value, 0, longest));
    osc.send(messages[i], remote);
  }

  stroke(foreground);
  fill(background);
  ellipse(mouseX, mouseY, 20, 20);
}

class Node {
  float x, y, value;
  int n;
  Node(int number, float posX, float posY) {
    n = number;
    x = posX;
    y = posY;
  }

  void display() {
    push();
    noStroke();
    fill(foreground);
    ellipse(x, y, 12, 12);
    textSize(12);
    text(n, x - 16, y - 13);
    value = constrain(longest - dist(x, y, mouseX, mouseY), 0, longest);
    float arcSize = map(value, 0, longest, 0, TWO_PI);
    fill(0, 100);
    arc(x, y, 25, 25, 0, arcSize);
    pop();
  }
}

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle(); 
  popMatrix();
}
