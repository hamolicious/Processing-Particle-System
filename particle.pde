class Particle {

  PVector pos, vel, acc, oldPos;
  float friction;
  float G = 100;
  color c;
  boolean isAlive = true;

  Particle() {
    pos = new PVector(random(particleSize, width - particleSize), random(particleSize, height - particleSize));
    oldPos = pos.copy();
    acc = new PVector();
    vel = PVector.random2D();
    friction = 0.995;

    if (useRandomColors) {
      c = color(random(256), random(256), random(256));
    } else {
      c = color(255);
    }
  }

  void display() {
    if (!showPath) {
      stroke(c);
    } else { 
      stroke(c, alpha);
    }

    strokeWeight(particleSize);
    line(oldPos.x, oldPos.y, pos.x, pos.y);

    oldPos = pos.copy();
  }

  void attract(ArrayList<PVector> targets) {
    for (PVector target : targets) {
      PVector force = target.copy().sub(pos);
      float distSqrd = force.magSq();
      distSqrd = constrain(distSqrd, 300, 800);

      // F = G/D*D
      float strength = G / distSqrd;

      force.setMag(strength);
      acc.add(force);
    }
  }

  void repulse(ArrayList<PVector> targets) {
    for (PVector target : targets) {
      PVector force = target.copy().sub(pos);
      float distSqrd = force.magSq();
      distSqrd = constrain(distSqrd, 300, 800);

      // F = G/D*D
      float strength = G / distSqrd;

      force.setMag(strength);
      force.mult(-1);
      acc.add(force);
    }
  }

  void impulse(ArrayList<PVector> targets) {
    for (PVector target : targets) {

      if (dist(pos.x, pos.y, target.x, target.y) < impulseRange) {
        PVector dir = target.copy().sub(pos);
        dir.mult(-1);
        dir.setMag(2);
        acc.add(dir);
      }
    }
  }

  void update() {
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
    vel.mult(friction);

    clampToScreen();
  }

  void clampToScreen() {
    if (pos.x >= width-particleSize/2 || pos.x <= particleSize/2) {
      vel.x *= (-1);
    }
    if (pos.y >= height-particleSize/2 || pos.y <= particleSize/2) {
      vel.y *= (-1);
    }
  }
}
