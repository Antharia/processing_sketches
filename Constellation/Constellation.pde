Agent[] agents;
int nbAgents = 50;

void setup() {
  size(800, 600);
  background(50);
  agents = new Agent[nbAgents];
  for (int i = 0; i < nbAgents; i++) {
    agents[i] = new Agent(random(width), random(height), random(1), random(1));
  }
}

void draw() {
  background(50);
  for (int i = 0; i < nbAgents; i++) {
    for (int j = 0; j < nbAgents; j++) {
      float distance = dist(agents[i].posX, agents[i].posY, agents[j].posX, agents[j].posY);
      if (distance < 100) {
        stroke(250, 0, 0);
        line(agents[i].posX, agents[i].posY, agents[j].posX, agents[j].posY);
      }
      //if (distance > 799) {
      //  stroke(250, 10);
      //  line(agents[i].posX, agents[i].posY, agents[j].posX, agents[j].posY);
      //}
    }
    agents[i].update();
    agents[i].display();
  }
}