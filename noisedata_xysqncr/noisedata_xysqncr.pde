int fg, bg;
int cols, rows;
int cellSize;
int[][] squares;
float currentTime;
int speed;
int cursorX, cursorY;
int frame;
void setup() {
  size(800, 600);
  fg = 70;
  bg = 240;
  cols = 2;
  rows = 2;
  speed = 5;
  cursorX = 0;
  cursorY = 0;
  frame = 1;
  gridInit();
}

void draw() {
  background(bg);

  translate(cellSize*2, cellSize*2);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      stroke(fg);
      fill(bg);
      int coordX = i * cellSize;
      int coordY = j * cellSize;
      if (squares[i][j] == 0) {
        fill(bg);
      } else if (squares[i][j] == 1) {
        fill(fg);
      } else if (squares[i][j] == 2) {
        stroke(200, 10, 10);
      }
      rect(coordX, coordY, cellSize, cellSize);
    }
  }
  //currentTime = millis();
  push();
  fill(fg);
  text(frameCount, 0, -cellSize/2);
  text(cursorX, 50, -cellSize/2);
  text(cursorY, 70, -cellSize/2);
  text(cols, 100, -cellSize/2);
  text(rows, 120, -cellSize/2);
  pop();
  gridInit();
  if (cursorX < cols && cursorY < rows) {
    squares[cursorX][cursorY] = 1;
  }
  if (frameCount % speed == 0) {
    frame++;
    println(frame);
  }
  cursorX = frame % cols;
  if (cursorX == cols - 1) {
    cursorY = frame % rows;
  }

  // cross the grid

  // trigger events
}

void gridInit() {
  cellSize = min(int(height / (rows + 4)), int(width / (cols + 4)));
  squares = new int[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      squares[i][j] = 0;
    }
  }
}

void keyPressed() {
  if (key == 'c') {
    cols++;
    gridInit();
  }
  if (key == 'C') {
    cols--;
    gridInit();
  }
  if (key == 'r') {
    rows++;
    gridInit();
  }
  if (key == 'R') {
    rows--;
    gridInit();
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
