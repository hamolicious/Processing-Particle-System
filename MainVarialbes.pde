// HOW MANY PARTICLES TO ADD
int numOfParticles = 300;

// IF EACH PARTICLE WILL HAVE A RANDOM COLOR
boolean useRandomColors = false;

// CONTROLLS SIZE OF PARTICLES
float particleSize = 3;

// CONTROLLS HOW CLOSE A PARTICLE HAS TO BE TO GET IMPULSED
float impulseRange = 8;

// MIN AND MAX FOR THE DECAY RANGES
float max = 15;
float min = 10;

// HOW FAST THE COLOURS DECAY ON THE SCREEN IN THE DRAW PATH MODE (ACTIVATED BY HITTING SPACE)
float redDecaySpeed = random(min, max);
float greenDecaySpeed = random(min, max);
float blueDecaySpeed = random(min, max);

// WHEN ALL DECAY VALUES ARE 0, ALPHA GETS INITIALISED WITH THIS VALUE
float presetAlpha = 15;
