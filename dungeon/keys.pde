int keysCount = 0;

void drawKeysCount() {
  textAlign(LEFT,CENTER);
  textFont(fontGG);
  textSize(40);
  fill(249, 166, 2);
  if (keysCount > 0) {
    fill(255, 225, 0);
    image(keysImage, width - 135, height - 75, 50, 80);
    text(": " + keysCount, width - 90, height - 35);
  }
}
