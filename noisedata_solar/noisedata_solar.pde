int fg, bg;
int precision;
float angle, radius;
float coordX, coordY;
float cursorX, cursorY;
float cursorAngle;

//TODO each planet is an object;

void setup() {
  size(800, 600);
  fg = 70;
  bg = 240;
  precision = 120;
  angle = 0;
  radius = 200;
  cursorAngle = 0;
}

void draw() {
  background(bg);
  stroke(fg);
  angle = PI/4;
  translate(width/2, height/2);

  push();
  rotate(radians(mouseX));
  fill(bg);
  ellipse(0, 0, 50, 50);
  noFill();
  ellipse(0, 0, mouseX, mouseY);
  fill(bg);
  cursorX = sin(cursorAngle) * mouseX/2;
  cursorY = cos(cursorAngle) * mouseY/2;
  ellipse(cursorX, cursorY, 30, 30);
  cursorAngle += 0.05;
  pop();
}

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}
