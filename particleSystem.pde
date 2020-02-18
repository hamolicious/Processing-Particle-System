Particle[] particles;
ArrayList<PVector> attractors;
ArrayList<PVector> repulsors;
ArrayList<PVector> impulsers;

boolean showPath = false;
float alpha = 255;

void setup() {
  size(600, 500);
  background(0);

  particles = new Particle[numOfParticles];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }

  attractors = new ArrayList<PVector>();
  repulsors = new ArrayList<PVector>();
  impulsers = new ArrayList<PVector>();

  if (redDecaySpeed == 0 && greenDecaySpeed == 0 && blueDecaySpeed == 0) {
    alpha = presetAlpha;
  }
}

void draw() {  
  if (!showPath) {
    background(0);
  } 

  drawAttractor();
  drawRepulsor();
  drawImpulsor();
  drawParticles();



  if (showPath) {
    dimmer();
  }
}

void dimmer() {
  loadPixels();
  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {
      color c = pixels[i*width+j];

      if (brightness(c) != 0) {
        float r = red(c);
        float g = green(c);
        float b = blue(c);

        c = color(r-redDecaySpeed, g-greenDecaySpeed, b-blueDecaySpeed);
      }
      pixels[i*width+j] = c;
    }
  }  
  updatePixels();
}

void drawParticles() {
  for (Particle particle : particles) {
    particle.attract(attractors);
    particle.repulse(repulsors);
    particle.impulse(impulsers);

    particle.update();
    particle.display();
  }
}

void drawAttractor() {
  stroke(0, 255, 0);
  strokeWeight(particleSize);
  for (PVector attractor : attractors) {
    point(attractor.x, attractor.y);
  }
}

void drawRepulsor() {
  stroke(255, 0, 0);
  strokeWeight(particleSize);
  for (PVector repulsor : repulsors) {
    point(repulsor.x, repulsor.y);
  }
}

void drawImpulsor() {
  stroke(0, 0, 255);
  strokeWeight(particleSize);
  for (PVector impulser : impulsers) {
    point(impulser.x, impulser.y);
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    attractors.add(new PVector(mouseX, mouseY));
  } else if (mouseButton == RIGHT) {
    repulsors.add(new PVector(mouseX, mouseY));
  }
}

void keyPressed() {
  if (key == ' ') {
    background(0);
    showPath = !showPath;
  }
}

void mouseWheel() {
  impulsers.add(new PVector(mouseX, mouseY));
}
