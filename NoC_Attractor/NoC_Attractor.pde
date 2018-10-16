int nbAgents = 500;
Agent[] agents = new Agent[nbAgents];

void setup() {
  size(800, 800);
  for (int i = 0; i < agents.length; i++) {
    agents[i] = new Agent();    
  }
}

void draw() {
  background(250);
  //noCursor();
  for (int i = 0; i < agents.length; i++) {
     agents[i].update();
     agents[i].borders();
     agents[i].display();
  }
}
