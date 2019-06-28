int bg, fg;
int[] histogram;
int nbBars;
int cellSize;
int cursorX;
int maxLevel;
int frame;
int speed;

// TODO draw read position
// TODO time sequence
// TODO write bar sequences
// TODO move write position

void setup() {
  size(800, 600);
  // foreground and background colors
  bg = 240;
  fg = 70;
  // number of vertical bars
  nbBars = 8;
  cellSize = 20;
  // initialize cursor position
  cursorX = 0;
  // max number of cells per bar
  maxLevel = 16;
  frame = 0;
  speed = 10;
  histogramInit();
  // histogram random init
  for (int i = 0; i < nbBars; i++) {
    histogram[i] = round(random(10))+1;
  }
}

void draw() {
  background(bg);
  stroke(fg);
  fill(bg);
  histogramDisplay();
  drawCursor(cursorX);
  read();
}

void read() {
  frame = (frameCount/8 % nbBars);
  push();
  stroke(fg, 200);
  line(cellSize * 4 + cellSize * frame + cellSize / 2, 
    height - cellSize * 2 - cellSize, 
    cellSize * 4 + cellSize * frame + cellSize / 2, 
    height - cellSize *2 - cellSize * histogram[frame] - cellSize
    );
  pop();
}

void drawCursor(int posX) {
  // cursor y position, under histogram
  int posY = height - cellSize * 2;
  // move cursor when bars number decreases
  if (posX >= nbBars) {
    cursorX = nbBars - 1;
  }
  posX = cellSize * 4 + cellSize * posX;
  // draw cursor
  push();
  stroke(fg);
  fill(fg);
  beginShape();
  vertex(posX, posY);
  vertex(posX + cellSize / 2, posY - cellSize / 2);
  vertex(posX + cellSize, posY);
  endShape(CLOSE);
  pop();
}

void histogramInit() {
  histogram = new int[nbBars];
}

void histogramDisplay() {
  // draw a semi-transparent grid
  for (int i = 0; i < nbBars; i++) {
    int coordX = cellSize * 4 + cellSize * i;
    for (int k = 0; k < maxLevel; k++) {
      int coordY = height - cellSize * 4 - cellSize * k;
      stroke(fg, 20);
      rect(coordX, coordY, cellSize, cellSize);
    }
  }
  // draw histogram
  for (int i = 0; i < nbBars; i++) {
    int coordX = cellSize * 4 + cellSize * i;
    for (int j = 0; j < histogram[i]; j++) {
      int coordY = height - cellSize * 4 - cellSize * j;
      stroke(fg);
      rect(coordX, coordY, cellSize, cellSize);
    }
  }
}

void keyPressed() {
  // move cursor
  if (keyCode == RIGHT) {
    if (cursorX >= nbBars-1) {
      cursorX = nbBars-1;
    } else {
      cursorX++;
    }
  }
  if (keyCode == LEFT) {
    if (cursorX <= 0) {
      cursorX = 0;
    } else {
      cursorX--;
    }
  }
  // change number of cells
  if (keyCode == UP) {
    if (histogram[cursorX] >= maxLevel) {
      histogram[cursorX] = maxLevel;
    } else {
      histogram[cursorX]++;
    }
  }
  if (keyCode == DOWN) {
    if (histogram[cursorX] <= 0) {
      histogram[cursorX] = 0;
    } else {
      histogram[cursorX]--;
    }
  }
  // change number of histogram bars
  if (key == 'l') {
    nbBars++;
    int[] histogramTemp = append(histogram, 0);
    histogram = histogramTemp;
  }
  if (key == 'L') {
    nbBars--;
    shorten(histogram);
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
