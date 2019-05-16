import processing.sound.*;
SoundFile track;
FFT fft;
int bands = 512;
float[] spectrum = new float[bands];
float x1 = 0;
float y1 = 0;
float x2 = 0;
float y2 = 0;
float angle = 0;

void setup()
{
  size(1280, 720);
  background(255);
  track = new SoundFile(this, "filename.wav"); // change filename
  track.play();
  fft = new FFT(this, bands);
  fft.input(track);
}

void draw()
{
  fft.analyze();
  strokeWeight(4);

  float radius = (height / 2) - 10;
  translate(width / 2, height / 2);
  for (int i = 0; i < 20; i++) {
    stroke(map(fft.spectrum[i], 0, 0.7, 255, 0));
    x1 = cos(angle) * radius;
    y1 = sin(angle) * radius;
    radius -= map(i, 0, 512, 17, 1);
    x2 = cos(angle) * radius;
    y2 = sin(angle) * radius;
    line(x1, y1, x2, y2);
  }
  angle += 0.01;
  //saveFrame("frames/circular_######.png");
}
