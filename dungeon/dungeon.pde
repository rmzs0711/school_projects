final int GAMEMODE_MENU = 0;
final int GAMEMODE_GAME = 1;
final int GAMEMODE_PAUSE = 2;
final int GAMEMODE_WIN = 3;
final int GAMEMODE_DEFEAT = 4;

int gamemode = GAMEMODE_MENU;

void setup() {
  fullScreen();
  background(0);
  textSetup();
  imageSetup();
  healthSetup();
  atackSystemSetup();
  soundSetUp();
}

void draw() {
  noStroke();
  switch(gamemode) {
  case GAMEMODE_MENU:
    gamemodeMenuDraw(); 
    break;
  case GAMEMODE_GAME:
    gamemodeGameDraw();
    break;
  case GAMEMODE_PAUSE:
    gamemodePauseDraw(); 
    break;
  case GAMEMODE_WIN:
    gamemodeWinDraw();
    break;
  case GAMEMODE_DEFEAT:
    gamemodeDefeatDraw();
    break;
  }
}

void keyPressed() {
  switch(gamemode) {
  case GAMEMODE_MENU:
    gamemodeMenuKey();
    break;
  case GAMEMODE_GAME:
    gamemodeGameKey();    
    break;
  case GAMEMODE_PAUSE:
    gamemodePauseKey();
    break;
  case GAMEMODE_WIN:
    gamemodeWinKey();
    restart();
    break;
  case GAMEMODE_DEFEAT:
    gamemodeDefeatKey();
    restart();
    break;
  }
}

void mousePressed() {
  if (arrowState == STOP_ARROW_SHOOT) {
    mouseInitArrow();
    arrowState = START_ARROW_SHOOT;
  }
}
