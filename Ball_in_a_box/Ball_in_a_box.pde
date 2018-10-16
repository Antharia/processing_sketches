float time = 0;
PVector pos, vel;
int d = 10, s = 200;

void setup() {
  size(500, 500, P3D);
  pos = new PVector(0, 0, 0);
  vel = new PVector(2, 2.2, 1.8);
}

void draw() {
  background(50);
  stroke(250);
  noFill();
  translate(width/2, height/2);
  box(s);
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  sphere(d);
  popMatrix();
  pos.add(vel);
  if ((pos.x < -s/2 + d/2) || (pos.x > s/2 - d/2)) vel.x *= -1;
  if ((pos.y < -s/2 + d/2) || (pos.y > s/2 - d/2)) vel.y *= -1;
  if ((pos.z < -s/2 + d/2) || (pos.z > s/2 - d/2)) vel.z *= -1;

  sphereDetail(10);
  float eyeZ = map(sin(time), 0, 1, 100, 248);
  float eyeY = map(noise(time/2), 0, 1, 150, 1000);
  float eyeX = map(cos(time), 0, 1, 502, 795);
  camera(eyeX, eyeY, eyeZ, 170.0, 277.6, 8.6, 0.0, 1.0, 0.0);

  time+=0.01;
}
