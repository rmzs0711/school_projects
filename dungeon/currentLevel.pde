int level = -1;
char [][] thisLevel;
int levelWidth;
int levelHeight;

// Загрузка уровня перед его рисованием
void loadLevel() {
  level++;
  if (level >= LEVELS.length) {
    background(0);
    gamemode = GAMEMODE_WIN;
    level = -1;
    
    // Остановка музыки игры
    unityGameSound.pause();
    unityGameSound.rewind();
    
    // Победная музыка
    winScreenSound.play();
  } else {
    levelWidth = LEVELS[level][0].length;
    levelHeight = LEVELS[level].length;
    thisLevel = new char [levelHeight][levelWidth];

    for (int y = 0; y < levelHeight; ++y) {
      for (int x = 0; x < levelWidth; ++x) {
        char cell = LEVELS[level][y][x];
        if (cell == 'H') {
          initHero(x, y);
          cell = FLOOR;
        }
        thisLevel[y][x] = cell;
      }
    }
  }
}

// Рисование самого уровня
void drawLevel() {
  float cellSize = min(width / levelWidth, height / levelHeight);
  float areaWidth = cellSize * levelWidth;
  float areaHeight = cellSize * levelHeight;
  float centeringX = (width - areaWidth) / 2;
  float centeringY = (height - areaHeight) / 2;

  for (int y = 0; y < levelHeight; ++y) {
    for (int x = 0; x < levelWidth; ++x) {
      float xPos = centeringX + x * cellSize;
      float yPos = centeringY + y * cellSize;

      char cell = thisLevel[y][x];
      switch (cell) {
      case HERO:
      case FLOOR:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        break;
      case WALL:
        image(wallImage, xPos, yPos, cellSize, cellSize);
        if (arrowEndX >= xPos && arrowEndX <= xPos + cellSize &&
            arrowEndY >= yPos && arrowEndY <= yPos + cellSize) {
          arrowState = STOP_ARROW_SHOOT;
          xPos = centeringX + heroX * cellSize;
          yPos = centeringY + heroY * cellSize;
          arrowStartX = xPos + cellSize / 2;
          arrowStartY = yPos + cellSize / 2;
        }
        break;
      case EXIT:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        exitSprite.draw(xPos, yPos, cellSize, cellSize);
        break;
      case DOOR_LOCKED_VERT:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        image(doorLockedVertImage, xPos, yPos, cellSize, cellSize);
        break;
      case DOOR_OPENED_VERT:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        image(doorOpenedVertImage, xPos, yPos, cellSize, cellSize);
        break;
      case DOOR_LOCKED_HOR:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        image(doorLockedHorImage, xPos, yPos, cellSize, cellSize);
        break;
      case DOOR_OPENED_HOR:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        image(doorOpenedHorImage, xPos, yPos, cellSize, cellSize);
        break;
      case VOID:
        fill(0);
        rect(xPos, yPos, cellSize, cellSize);
        break;
      case COIN:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        coinSprite.draw(xPos, yPos, cellSize, cellSize);
        break;
      case OGRE:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        int i = int(random(2));
        if (i == 0) {
          image(ogreImageRight, xPos, yPos, cellSize, cellSize);
        } else {
          image(ogreImageLeft, xPos, yPos, cellSize, cellSize);
        }
        // Убийство огра
        if (arrowEndX >= xPos && arrowEndX <= xPos + cellSize &&
           arrowEndY >= yPos && arrowEndY <= yPos + cellSize ||
           arrowStartX >= xPos && arrowStartX <= xPos + cellSize &&
           arrowStartY >= yPos && arrowStartY <= yPos + cellSize) {
          // Остановить стрелу
          arrowState = STOP_ARROW_SHOOT;
   
          // Убрать координаты стрелы с места убийства
          xPos = centeringX + heroX * cellSize;
          yPos = centeringY + heroY * cellSize;
          arrowStartX = xPos + cellSize / 2;
          arrowStartY = yPos + cellSize / 2;
          arrowEndX = arrowStartX;
          arrowEndY = arrowStartY;
          
          enemyHurt.play();
          enemyHurt.rewind();
          
          score += POINTS_FOR_KILL;
          int loot = (int) random(0, 9);
          switch(loot) {
          case 0:
            thisLevel[y][x] = FLOOR;
            break;
          case 1:
            thisLevel[y][x] = WATER_BUCKET;
            break;
          case 2:
            thisLevel[y][x] = COIN;
            break;
          case 3:
            thisLevel[y][x] = GEM;
            break;
          case 4:
            thisLevel[y][x] = KEYS;
            break;
          case 5:
          case 6:
          case 7:
          case 8:
            thisLevel[y][x] = FLOOR;
            thisLevel[y][x] = OGRE;
            break;
          }
        }
        break;
      case SKELETON:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        int g = int(random(2));
        if (g == 0) {
          image(skeletonImageRight, xPos, yPos, cellSize, cellSize);
        } else {
          image(skeletonImageLeft, xPos, yPos, cellSize, cellSize);
        }
        // Убийство скелета
        if (arrowEndX >= xPos && arrowEndX <= xPos + cellSize &&
           arrowEndY >= yPos && arrowEndY <= yPos + cellSize ||
           arrowStartX >= xPos && arrowStartX <= xPos + cellSize &&
           arrowStartY >= yPos && arrowStartY <= yPos + cellSize) {
          // Остановить стрелу
          arrowState = STOP_ARROW_SHOOT;
          
          // Убрать координаты стрелы с места убийства
          xPos = centeringX + heroX * cellSize;
          yPos = centeringY + heroY * cellSize;
          arrowStartX = xPos + cellSize / 2;
          arrowStartY = yPos + cellSize / 2;
          arrowEndX = arrowStartX;
          arrowEndY = arrowStartY;
          
          enemyHurt.play();
          enemyHurt.rewind();
          
          score += POINTS_FOR_KILL;
          int loot = (int) random(0, 6);
          switch(loot) {
          case 0:
            thisLevel[y][x] = KEYS;
            break;
          case 1:
            thisLevel[y][x] = WATER_BUCKET;
            break;
          case 2:
            thisLevel[y][x] = COIN;
            break;
          case 3:
            thisLevel[y][x] = GEM;
            break;
          case 4:
            thisLevel[y][x] = FLOOR;
            thisLevel[y][x] = SKELETON;
            break;
          case 5:
            thisLevel[y][x] = FLOOR;
            break;
          }
        }
        break;
      case KEYS:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        image(keysImage, xPos, yPos, cellSize, cellSize);
        break;
      case LAVA:
        image(lavaImage, xPos, yPos, cellSize, cellSize);
        break;
      case HEALTH:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        image(healthFullImage, xPos + cellSize / 4, yPos + cellSize / 4, cellSize / 2, cellSize / 2);
        break;
      case OBSIDIAN:
        image(obsidianImage, xPos, yPos, cellSize, cellSize);
        break;
      case WATER_BUCKET:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        image(waterBucketImage, xPos, yPos, cellSize, cellSize);
        break;
      case GEM:
        image(floorImage, xPos, yPos, cellSize, cellSize);
        image(gemImage, xPos, yPos, cellSize, cellSize);
        break;
      }
    }
  }
}
