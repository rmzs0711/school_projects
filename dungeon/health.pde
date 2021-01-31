int healthSize = 50;
float healthXStart;
float healthX;
float healthY;
int healthCount = 5;
int health = 500;
int oneHealth = 100;
PImage []hearts = new PImage[healthCount];
PImage healthBar;

void drawHealth() {
  for (int i = 0; i < healthCount; i++) {
    if (health / oneHealth >= i + 1) {
      hearts[i] = healthFullImage;
    } else if (health > oneHealth * i) {
      hearts[i] = healthHalfImage;
    } else {
      hearts[i] = healthEmptyImage;
    }
    image(hearts[i], healthX, healthY, healthSize, healthSize);
    healthX += healthSize + 5;
  }
  healthX = healthXStart;
}
