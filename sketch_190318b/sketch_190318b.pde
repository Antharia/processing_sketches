float percent;
float nFramesInLoop = 120;

void setup() {
  size(500, 500);
  smooth();
}

void draw() {
  background(250);

  percent = (float) (frameCount % nFramesInLoop) / (float) nFramesInLoop;
  render(percent);
}

void render(float percent) {
  //float radius = 80;
  //float angle = percent * TWO_PI;
  //float posX = radius * cos(angle);
  //float posY = radius * sin(angle);
  //fill(250);
  //stroke(0);
  //strokeWeight(3);
  //translate(width/2, height/2);
  //line(0, 0, posX, posY);
  //ellipse(posX, posY, 20, 20);
  strokeWeight(2);
  float angle = percent * TWO_PI;
  int gridSize = 30;
  float side = cos(percent * TWO_PI) * gridSize;
  float tX = width / gridSize;
  float tY = height / gridSize;
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      pushMatrix();
      translate(tX, tY);
      rotate(angle);
      float posX = 0;
      float posY = 0;
      rect(posX, posY, side, side);
      popMatrix();
      tX += width / gridSize;
    }
    tY += height /gridSize;
    tX = width / gridSize;
  }
}
