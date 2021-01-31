// Меню
void gamemodeMenuDraw() {
  image(backgroundImage, 0, 0, width, height);
  textFont(fontPixelHour);
  fill(249, 166, 2);
  textSize(200);
  textAlign(CENTER, CENTER);
  text("DUNGEON", width / 2, height / 2);

  textFont(fontGG);
  fill(225);
  textSize(50);
  text("Press ENTER to start the game", width / 2, height / 4);
}

// Игра
void gamemodeGameDraw() {  
  background(0);
  noStroke();
  drawLevel();
  drawHero();
  drawKeysCount();
  drawHealth();
  drawBucketsCount();
  if (arrowState == START_ARROW_SHOOT) {
    atackDraw();
  }
  textFont(fontGG);
  fill(255);
  textSize(50);
  textAlign(LEFT, TOP);
  text("SCORE: " + score, 0, 80);
}

// Пауза
void gamemodePauseDraw() {
  background(0);
  fill(100);
  textSize(50);
  textAlign(CENTER, CENTER);
  text("Press ESC to resume", width / 2, height / 4);
  text("Press ENTER to exit", width / 2, height * 3 / 4);
  
  textSize(100);
  fill(255);
  text("PAUSE", width / 2, height / 2);
}

// Победный экран
void gamemodeWinDraw() {
  firework();
  textAlign(CENTER, CENTER);
  textFont(fontPixelHour);
  fill(255, 0, 0);
  textSize(120);
  text("YOU HAVE WON", width / 2, height / 10);

  textFont(font1982);
  fill(100);
  textSize(50);
  text("Press ENTER to exit to menu", width / 2, height * 9 / 10);

  textFont(fontGG);
  fill(245, 152, 35);
  textSize(70);
  text("YOUR SCORE: " + score, width / 2, height * 2 / 7);
}

// Экран поражения
void gamemodeDefeatDraw() {
  image(backgroundImage, 0, 0, width, height);
  textAlign(CENTER, CENTER);
  textFont(fontGG);
  fill(255, 0, 0);
  textSize(120);
  text("DEFEAT", width / 2, height / 10);

  textFont(fontGG);
  fill(245, 152, 35);
  textSize(70);
  text("YOUR SCORE: " + score, width / 2, height * 2 / 7);

  textFont(fontGG);
  fill(255);
  textSize(50);
  text("Press ENTER to exit to menu", width / 2, height * 9 / 10);

  skullSprite.draw(width / 3, height / 3 + 50, width / 3, height / 3 + 60);
}
