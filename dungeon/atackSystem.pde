float arrowLength;

final int STOP_ARROW_SHOOT = 0;
final int START_ARROW_SHOOT = 1;
int arrowState = STOP_ARROW_SHOOT;

final int ARROW_MODULE_DX = 50;
final int ARROW_MODULE_DY = 50;
int arrowDX;
int arrowDY;

float arrowStartX;
float arrowStartY;
float arrowEndX;
float arrowEndY;

float arrowHypotenuse;
float arrowXLeg;
float arrowYLeg;

float arrowCos;
float arrowSin;

// Найти начало стрелы
void keyInitArrow() {
  float cellSize = min(width / levelWidth, height / levelHeight);
  float areaWidth = cellSize * levelWidth;
  float areaHeight = cellSize * levelHeight;
  float centeringX = (width - areaWidth) / 2;
  float centeringY = (height - areaHeight) / 2;

  float xPos = centeringX + heroX * cellSize;
  float yPos = centeringY + heroY * cellSize;
  
  arrowStartX = xPos + cellSize / 2;
  arrowStartY = yPos + cellSize / 2;
  arrowLength = cellSize / 2;
}

// Найти направление и длинну стрелы
void mouseInitArrow() {
  arrowXLeg = mouseX - arrowStartX;
  arrowYLeg = mouseY - arrowStartY;
  arrowHypotenuse = sqrt(arrowXLeg * arrowXLeg + arrowYLeg * arrowYLeg);

  arrowCos = arrowXLeg / arrowHypotenuse;
  arrowSin = arrowYLeg / arrowHypotenuse;

  arrowEndX = arrowStartX + arrowLength * arrowCos;
  arrowEndY = arrowStartY + arrowLength * arrowSin;

  if (mouseX > arrowStartX) {
    arrowDX = ARROW_MODULE_DX;
  } else {
    arrowDX = ARROW_MODULE_DX;
  }
  if (mouseY > arrowStartY) {
    arrowDY = ARROW_MODULE_DY;
  } else {
    arrowDY = ARROW_MODULE_DY;
  }
}

// Полёт стрелы
void atackDraw() {
  if (arrowStartX > 0 && arrowStartX < width &&
      arrowStartY > 0 && arrowStartY < height) {
    stroke(157, 74, 22);
    line(arrowStartX, arrowStartY, arrowEndX, arrowEndY);
    noStroke();
    fill(100);
    ellipse(arrowEndX, arrowEndY, arrowLength / 4, arrowLength / 4);
    
    arrowStartX += arrowDX * arrowCos;
    arrowStartY += arrowDY * arrowSin;
    arrowEndX += arrowDX * arrowCos;
    arrowEndY += arrowDY * arrowSin;
  } else {
    arrowState = STOP_ARROW_SHOOT;
    float cellSize = min(width / levelWidth, height / levelHeight);
    float areaWidth = cellSize * levelWidth;
    float areaHeight = cellSize * levelHeight;
    float centeringX = (width - areaWidth) / 2;
    float centeringY = (height - areaHeight) / 2;

    float xPos = centeringX + heroX * cellSize;
    float yPos = centeringY + heroY * cellSize;

    arrowStartX = xPos + cellSize / 2;
    arrowStartY = yPos + cellSize / 2;
  }
}
