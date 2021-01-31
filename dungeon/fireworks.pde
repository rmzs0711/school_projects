float startFireworkX;
float startFireworkY;
float startFireworkCopyX;
float startFireworkCopyY;
float sinusFirework;
float cosinusFirework;
float angleFirework = 0;
float fireworkDR = 0;
int f = 1;

float red;
float green;
float blue;
final int START_RADIUS = 40;
int radius = START_RADIUS;

int pointsCount = 0;
int fireworkMode = 0;
final int FIREWORK_COUNT_MAX = 20;
int count = 0;

float[]ostX = new float[FIREWORK_COUNT_MAX * 9];
float[]ostY = new float[FIREWORK_COUNT_MAX * 9];
float[]fillR = new float[FIREWORK_COUNT_MAX * 9];
float[]fillG = new float[FIREWORK_COUNT_MAX * 9];
float[]fillB = new float[FIREWORK_COUNT_MAX * 9];


// Салют
void fireworkSteps() {
  if (f == 1) {
    fill(red, green, blue);
  } else {
    fill(0);
  }
  noStroke();
  startFireworkX = startFireworkCopyX;
  startFireworkY = startFireworkCopyY;
  cosinusFirework = cos(radians(angleFirework)) * fireworkDR;
  sinusFirework = sin(radians(angleFirework)) * fireworkDR;
  ellipse(startFireworkX + cosinusFirework, startFireworkY + sinusFirework, radius, radius);
  angleFirework += 40;
  if (radians(angleFirework) > 2 * PI) {
    fireworkDR += 20;
    angleFirework = 0;
    radius -= 5;
  } else if (fireworkDR == 180 && radius == -5) {
    ostX[pointsCount] = startFireworkX + cosinusFirework;
    ostY[pointsCount] = startFireworkY + sinusFirework;
    
    fillR[pointsCount] = red;
    fillG[pointsCount] = green;
    fillB[pointsCount] = blue;

    pointsCount++;
    
  }
  if (fireworkDR > 180 && fireworkMode == 0) {
    f = 0;
    fireworkMode = 1;
    fill(0);
    radius = START_RADIUS + 5;
    fireworkDR = 0;
  }
  if (fireworkDR > 200 && fireworkMode == 1) {
    count++;
    
    f = 1;
    red = random(255);
    blue = random(255);
    green = random(255);
    fill(red, green, blue);
    
    fireworkDR = 0;
    radius = START_RADIUS;
    startFireworkCopyX = random(width);
    startFireworkCopyY = random(height);
    
    fireworkMode = 0;
  }
}

// Для быстрой работы и поток частиц вниз
void firework() {
  if (count < FIREWORK_COUNT_MAX) {
    fireworkSteps();
    fireworkSteps();
    fireworkSteps();
    fireworkSteps();
    fireworkSteps();
    fireworkSteps();
    fireworkSteps();
  } else {
    fill(0, 0, 0, 5);
    rect(0, 0, width, height);
    for (int i = 0; i < pointsCount; i++) {
      fill(fillR[i], fillG[i], fillB[i]);
      ellipse(ostX[i], ostY[i], 5, 5);
      ostY[i] = ostY[i] + random(0, 1);
      if (ostY[i] > height) {
        ostY[i] = -1;
      }
    }
  }
}
