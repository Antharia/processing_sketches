class Agent {
  float posX;
  float posY;
  float velX;
  float velY;

  Agent(float aPosX, float aPosY, float aVelX, float aVelY) {
    posX = aPosX;
    posY = aPosY;
    velX = aVelX;
    velY = aVelY;
  }

  void update() {
    posX += velX;
    posY += velY;
    if (posX < 0) { 
      posX = 0;
      velX *= -1;
    }
    if (posX > width) {
      posX = width;
      velX *= -1;
    }
    if (posY < 0) {
       posY = 0;
       velY *= -1;
    }
    if (posY > height) {
       posY = height;
       velY *= -1;
    }
  }

  void display() {
    noStroke();
    fill(250);
    ellipse(posX, posY, 5, 5);
  }
}