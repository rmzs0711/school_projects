final int MENU_GAMEMODE = 0;
final int GAME1VS1_GAMEMODE = 1;
final int GAMEAI_GAMEMODE = 2;
final int PAUSE_GAMEMODE = 3;
final int WIN_SCREEN_GAMEMODE = 4;

int gamemode = MENU_GAMEMODE;
int pastGamemode;
PFont gameFont1982;
PFont fontPixelHour;
PFont fontGG;

Sprite fireSprite;
Sprite medalSprite;

void setup() {
  fullScreen();
  textSetup();
  menuSetup();
  gameSetup();
  clockSetup();
  fireSetup();
  medalSetup();
  crownSetup();
  soundSetUp();
}

void draw() {
  switch (gamemode) {
  case MENU_GAMEMODE:
    menuDraw();
    break;
  case GAME1VS1_GAMEMODE:
    gameDraw1VS1();
    clock();
    break;
  case GAMEAI_GAMEMODE:
    gameDraw1VS1();
    gameDrawAI();
    clock();
    break;
  case PAUSE_GAMEMODE:
    pauseDraw();
    break;
  case WIN_SCREEN_GAMEMODE:
    winScreenDraw();
    break;
  }
}

void keyPressed() {
  switch (gamemode) {
  case GAME1VS1_GAMEMODE:
    abilityKeyPressed();
    pauseKeyPressed();
    break;
  case GAMEAI_GAMEMODE:
    abilityKeyPressed();
    pauseKeyPressed();
    break;
  case PAUSE_GAMEMODE:
    break;
  case WIN_SCREEN_GAMEMODE:
  restartKeyPressed();
    break;
  }
}
