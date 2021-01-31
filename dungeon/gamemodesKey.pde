void gamemodeMenuKey() {
  if (key == ENTER) {
    gamemode = GAMEMODE_GAME;
    loadLevel();
    score = 0;
    
    unityGameSound.play();
    unityGameSound.loop();
  }
}

void gamemodeGameKey() {
  switch(key) {
  case 'w':        
    moveHero(0, -1);
    heroDirectionFB = HERO_BACK;
    break;
  case 's':
    moveHero(0, 1);
    heroDirectionFB = HERO_FRONT;
    break;
  case 'a':
    moveHero(-1, 0);
    heroDirectionRL = HERO_LEFT ;
    break;
  case 'd':
    moveHero(1, 0);
    heroDirectionRL = HERO_RIGHT;
    break;
  case ESC:
    key = 0;
    gamemode = GAMEMODE_PAUSE;
    break;
  }
}

void gamemodePauseKey() {
  if (keyCode == ESC) {
    key = 0;
    gamemode = GAMEMODE_GAME;
  } else if (keyCode == ENTER) {
    exit();
  }
}

void gamemodeWinKey() {
  if (keyCode == ENTER) {
    gamemode = GAMEMODE_MENU;
    // Сброс феерверков
    count = 0;
    pointsCount = 0;
    
    // Открутить песню назад
    winScreenSound.pause();
    winScreenSound.rewind();
  }
}

void gamemodeDefeatKey() {
  if (keyCode == ENTER) {
    gamemode = GAMEMODE_MENU;
    
    // Открутить песню назад
    defeatScreenSound.pause();
    defeatScreenSound.rewind();
  }
}
