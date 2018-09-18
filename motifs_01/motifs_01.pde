PImage squares[];

void setup() {
   size(800, 800);
   background(255);
   blendMode(DARKEST);
   for (int i=0; i<20; i++) {
      squares[i] = loadImage("carre.png"); 
   }
}