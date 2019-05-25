import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress remote;

OscMessage[] messages;

int nbNodes;
Node[] nodes;
float angle, radius;
float x, y;
float longest;
int foreground, background;
float posX, posY;
float inc, step, speed;
boolean mouseMode, noiseMode;

void setup() {
  size(1024, 768);
  foreground = 50;
  background = 240;
  ellipseMode(CENTER);
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

  // NOISE MODE
  inc = 0;
  step = 0.10;
  speed = 1;
  mouseMode = true;
  noiseMode = false;

  // OSC SETUP
  osc = new OscP5(this, 4444);
  remote = new NetAddress("127.0.0.1", 7777);
  messages = new OscMessage[nbNodes];
}

void draw() {
  background(background);
  ellipseMode(CENTER);
  modes();
  for (int i = 0; i < nbNodes; i++) {
    stroke(foreground);
    line(nodes[i].x, nodes[i].y, posX, posY);
    nodes[i].display();
    noStroke();
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
  ellipse(posX, posY, 15, 15);

  // MODES
  textSize(10);
  fill(foreground);
  if (noiseMode) {
    text("speed = " + round(speed*10), 10, height - 85);
    text("noise = " + round(step*100), 10, height - 70);
    text("increase/decrease speed : press i/d", 10, height - 55);
    text("increase/decrease chaos : press -/+", 10, height - 40);
  }
  text("noise mode : press n", 10, height - 25);
  text("mouse mode : press m", 10, height - 10);
  inc += step;
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
    ellipse(x, y, 20, 20);
    value = constrain(longest - dist(x, y, posX, posY), 0, longest);
    float arcSize = map(value, 0, longest, 0, TWO_PI);
    fill(foreground, 100);
    arc(x, y, 30, 30, PI/2, arcSize+PI/2);
    fill(background);
    textSize(10);
    textAlign(CENTER);
    text(n, x, y+4);
    pop();
  }
}

void keyPressed() {
  if (key == 'm' || key == 'M') {
    mouseMode = true;
    noiseMode = false;
  }
  if (key == 'n' || key == 'N') {
    mouseMode = false;
    noiseMode = true;
  }
  if (key == '+') {
    step += 0.01;
  }
  if (key == '-') {
    step -= 0.01;
  }
  if (key == 'i' || key == 'I') {
    speed += 0.1;
  }
  if (key == 'd' || key == 'D') {
    speed -= 0.1;
  }
  speed = speed < 0 ? 0 : speed;
  step = step < 0.01 ? 0.01 : step;
}

void modes() {
  if (mouseMode == true) {
    noCursor();
    posX = mouseX;
    posY = mouseY;
  }
  if (noiseMode == true) {
    cursor();
    if (dist(posX, posY, width/2, height/2) < radius) {
      posX += noise(inc) * speed * 2 - speed; 
      posY += noise(inc+100) * speed * 2 - speed;
    } else {
      if (posX > width/2) {
        posX -= noise(inc);
      } else {
        posX += noise(inc);
      }
      if (posY > height/2) {
        posY -= noise(inc);
      } else {
        posY += noise(inc);
      }
    }
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
