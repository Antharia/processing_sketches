PVector vec, coord;
int R, r, u, v;

void setup() {
  size(600, 600, P3D);
  stroke(230);
  fill(50);
  frameRate(60);
}

void draw() {
  background(230);
  r = 120; 
  R = 300;
  coord = new PVector();

  beginCamera();
  camera();
  translate(0, 0, -500);
  endCamera();

  translate(width/2, height/2);
  rotateY(radians(mouseX));
  rotateX(-radians(mouseY));

  int u_step, v_step;
  // multiple de 360
  u_step = 10; 
  v_step = 20;
  int u_start = frameCount;
  for (u = u_start; u < u_start + 360; u += u_step) {
    int v_start = frameCount;
    for (v = v_start; v < v_start + 360; v += v_step) {
      int dice = round(random(6));
      if (dice == 6) { fill(250); } else { fill(50); }
      beginShape();
      coord = tore(R, r, u - u_step/2, v - v_step/2);
      vertex(coord.x, coord.y, coord.z);
      coord = tore(R, r, u + u_step/2, v - v_step/2);
      vertex(coord.x, coord.y, coord.z);
      coord = tore(R, r, u + u_step/2, v + v_step/2);
      vertex(coord.x, coord.y, coord.z);
      coord = tore(R, r, u - u_step/2, v + v_step/2);
      vertex(coord.x, coord.y, coord.z);
      endShape(CLOSE);
    }
  }
}

PVector tore(float R, float r, float u, float v) {
  u = radians(u);
  v = radians(v);
  vec = new PVector();
  vec.x = (R+r*cos(v))*cos(u);
  vec.y = (R+r*cos(v))*sin(u);
  vec.z = r*sin(v);
  return vec;
}
