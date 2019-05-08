PVector vec, coord;
int u, v;
float increment = 0.0;
float radius = 100;
float[][] radius_array;
int array_size;
int u_step = 10;
int v_step = 10;

float u_off, v_off;

void setup() {
  size(600, 600, P3D);
  frameRate(60);
  stroke(40);
  radius_array = new float[360/u_step][360/v_step];
}

void draw() {
  background(240);
  fill(240);

  beginCamera();
  camera();
  translate(0, 0, -200);
  endCamera();
  translate(width/2, height/2);
  rotateX(radians(mouseY));
  rotateY(radians(mouseX));



  u_off = 0.0;

  for (u = 0; u < 360; u += u_step) {
    u_off += increment;
    v_off = 0.0;
    for (v = 0; v < 360; v += v_step) {
      v_off += increment;
      //radius_array[u/u_step][v/v_step] = 100 + noise(u_off, v_off) * 100;
      radius_array[u/u_step][v/v_step] = 200 + sin(radians(u_off)) * 12 + cos(radians(v_off)) * 12;
      radius = radius_array[u/u_step][v/v_step];
      beginShape();
      coord = sphere_point(radius, u+u_step/2, v+v_step/2);
      vertex(coord.x, coord.y, coord.z);
      coord = sphere_point(radius, u-u_step/2, v+v_step/2);
      vertex(coord.x, coord.y, coord.z);
      coord = sphere_point(radius, u-u_step/2, v-v_step/2);
      vertex(coord.x, coord.y, coord.z);
      coord = sphere_point(radius, u+u_step/2, v-v_step/2);
      vertex(coord.x, coord.y, coord.z);
      endShape(CLOSE);
    }
  }
  increment += 0.11;
}

PVector sphere_point(float radius, float u, float v) {
  vec = new PVector();
  u = radians(u);
  v = radians(v);
  vec.x = radius * cos(u) * cos(v);
  vec.y = radius * sin(u) * cos(v);
  vec.z = radius * sin(v);
  return vec;
}
