final int POINTS_FOR_COIN = 20;
final int POINTS_FOR_KEY = 10;
final int POINTS_FOR_HEALTH = 50;
final int POINTS_FOR_GEM = 100;
final int POINTS_FOR_KILL = 20;
final int POINTS_FOR_LAVA_DESTROY = 20;
final int POINTS_FOR_COMPLETE_LEVEL = 100;

int heroX;
int heroY;
int score = 0;

final int HERO_FRONT = 0;
final int HERO_BACK = 1;
final int HERO_RIGHT = 0;
final int HERO_LEFT = 1;
int heroDirectionFB = 0;
int heroDirectionRL = 0;

void initHero(int x, int y) {
  heroX = x;
  heroY = y;
}

void moveHero(int dx, int dy) {
  int nextX = heroX + dx;
  int nextY = heroY + dy;
  char cell = thisLevel[nextY][nextX];
  switch (thisLevel[nextY][nextX]) {
  case DOOR_LOCKED_VERT:    
    if (keysCount > 0) {
      thisLevel[nextY][nextX] = DOOR_OPENED_VERT;
      keysCount--;
      
      openDoorSound.play();
      openDoorSound.rewind();
    } else {
      lockedDoorSound.play();
      lockedDoorSound.rewind();
    }
    break;
  case DOOR_LOCKED_HOR:   
    if (keysCount > 0) {
      thisLevel[nextY][nextX] = DOOR_OPENED_HOR;
      keysCount--;
      
      openDoorSound.play();
      openDoorSound.rewind();
    } else {
      lockedDoorSound.play();
      lockedDoorSound.rewind();
    }
    break;
  case OGRE:
    health -= oneHealth;
    break;
  case SKELETON:
    health -= oneHealth / 2;
    break;
  case LAVA:
    if (bucketsCount > 0) {
      thisLevel[nextY][nextX] = OBSIDIAN;
      score += POINTS_FOR_LAVA_DESTROY;
      bucketsCount--;
    } else if (bucketsCount == 0) {
      heroX += dx;
      heroY += dy;        
      health -= oneHealth / 2;
    }
    break;
  default:
    if (cell != WALL) {
      walkSound.play();
      walkSound.rewind();
      
      heroX += dx;
      heroY += dy;
      if (arrowState == STOP_ARROW_SHOOT) {
        keyInitArrow();
      }
      switch (cell) {
      case EXIT:
        score += POINTS_FOR_COMPLETE_LEVEL;
        loadLevel();
        break;
      case COIN:
        score += POINTS_FOR_COIN;
        thisLevel[nextY][nextX] = FLOOR;
        
        pickUpCoinSound.play();
        pickUpCoinSound.rewind();
        break;
      case KEYS:        
        keysCount++;
        thisLevel[nextY][nextX] = FLOOR;
                
        pickUpKey.play();
        pickUpKey.rewind();
        break;
      case WATER_BUCKET:
        bucketsCount++;
        thisLevel[nextY][nextX] = FLOOR;
        break;
      case HEALTH:
        if (health / oneHealth < healthCount &&
            oneHealth * healthCount - health != oneHealth / 2) { // Здоровье на уровне
          health += oneHealth;
          thisLevel[nextY][nextX] = FLOOR;
        } else if (oneHealth * healthCount - health == oneHealth / 2) { // Если здоровье почти полное
          health += oneHealth / 2;
          thisLevel[nextY][nextX] = FLOOR;
          score += POINTS_FOR_HEALTH;
        }
        break;
      case GEM:
      // Звук подбора кристалла
        pickUpGemSound.play();
        pickUpGemSound.rewind();
        
        score += POINTS_FOR_GEM;
        thisLevel[nextY][nextX] = FLOOR;
        break;
      }
    }
  }
  if (health == 0) {
    gamemode = GAMEMODE_DEFEAT;
    
    unityGameSound.pause();
    unityGameSound.rewind();
    
    defeatScreenSound.play();
  }
}

void drawHero() {
  float cellSize = min(width / levelWidth, height / levelHeight);
  float areaWidth = cellSize * levelWidth;
  float areaHeight = cellSize * levelHeight;
  float centeringX = (width - areaWidth) / 2;
  float centeringY = (height - areaHeight) / 2;

  float xPos = centeringX + heroX * cellSize;
  float yPos = centeringY + heroY * cellSize;

  // Выбор нужного направления героя
  switch(heroDirectionFB) {
  case HERO_FRONT:
    if (heroDirectionRL == 0) {
      heroImage = heroImageFrontRight;
    } else {
      heroImage = heroImageFrontLeft;
    }
    break;
  case HERO_BACK:
    if (heroDirectionRL == 0) {
      heroImage = heroImageBackRight;
    } else {
      heroImage = heroImageBackLeft;
    } 
    break;
  }
  image(heroImage, xPos, yPos, cellSize, cellSize);

  // Нахождение на лаве
  if (thisLevel[heroY][heroX] == LAVA) {
    health -= oneHealth / 2;
  }
  if (health == 0) {
    gamemode = GAMEMODE_DEFEAT;
  }
}
