class Agent {
  PVector pos, vel, acc;
  float mass;
  float topSpeed;
  

  Agent() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    mass = random(10)+1;
    topSpeed = 6;
  }

  void update() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector direction = PVector.sub(mouse, pos);
    direction.normalize();
    direction.mult(0.8);
    acc = direction;
    acc.div(mass);
    vel.add(acc);
    vel.limit(topSpeed);
    pos.add(vel);
  }

  void display() {
    stroke(50, 50);
    fill(100, 150);
    ellipse(pos.x, pos.y, mass, mass);
  }

  void borders() {
    if (pos.x > width) {
      pos.x = 0;
    } else if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.y > height) {
      pos.y = 0;
    } else if (pos.y < 0) {
      pos.y = height;
    }
  }
}
