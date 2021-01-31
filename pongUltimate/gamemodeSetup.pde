// Переменные для блоков меню 
final float BLOCK_WIDTH = 200;
final float BLOCK_HEIGHT = 100;
float blockX1;
float blockY1;
float blockX2;
float blockY2;
String lName, rName;

// Константы для ракеток 
int rPaddleHeight = 90;
int lPaddleHeight = 90;
final int PADDLE_WIDTH = 10;
final int PADDLE_HALF_HEIGHT = rPaddleHeight / 2;

// Левая ракетка
int lPaddleX;
int lPaddleY;
int lPaddleDY = 17;

// Правая ракетка
int rPaddleX;
int rPaddleY;
int rPaddleDY = 17;

// AI ракетка
int AIPaddleDY = 6;

// Константы и переменные шарика
final int DELAY_DISTANCE = 300;
final int RADIUS = 10;
final int DIAMETER = RADIUS * 2;

int x, y;
int dx = 8;
int dy = 8;
int pastDX;
int pastDY;

// Счёт
final int SCORE_MARGIN_TOP = 50;
final int SCORE_MARGIN_SIDE = 500;

int lScore = 0;
int rScore = 0;

// Первая помощь
int bonus = 0;

// Способности
final int ABILITY_WIDTH = 40;
final int ABILITY_HEIGHT = 40; 

int xAbility, yAbility;
int startAbility = 0;
int lAbilityScore = 3; // Счёт способностей
int rAbilityScore = 3;

// Цвет магического шарика
int colA = 0;
float colR = random(255);
float colG = random(255);
float colB = random(255);

// Огонь переменные
int fireWidth;
final int fireHeight = 250;

int fireX = 0;

// Часы переменные
int ROUND_MAX_MINUTE = 2;
float xClock;
float yClock;
float angle = 0;
final float CLOCK_SIZE = 60;
float endX;
float endY;
int roundMinute = ROUND_MAX_MINUTE;

// Корона переменные 
PImage crownImage;
int crownWidth, crownHeight;

// Медаль переменные
float medalX;
float medalY;
final int MEDAL_WIDTH = 200;
final int MEDAL_HEIGHT = 200;

// Анимация
class Sprite {
  PImage[] images;
  int frame;

  int skip, _skip;
  int time = -1;

  Sprite(String imagePrefix, int count, String extension) {
    this(imagePrefix, count, extension, 3);
  }

  Sprite(String imagePrefix, int count, String extension, int skip) {
    images = new PImage[count];

    for (int i = 0; i < count; i++) {
      String fileName = imagePrefix + i + extension;
      images[i] = loadImage(fileName);
    }

    this.skip = skip;
    _skip = skip;
  }

  void draw(float x, float y, float width, float height) {
    if (time < 0 || time > 0) {
      _skip--;
      if (_skip < 0) {
        _skip = skip;
        frame = (frame + 1) % images.length;
      }
      if (time > 0) {
        --time;
      }

      image(images[frame], x, y, width, height);
    } else {
      image(images[0], x, y, width, height);
    }
  }
}

// Звук
import ddf.minim.*;
 
// Эффекты и бонусы
Minim minim;
AudioPlayer runSound;
AudioPlayer ballHit;
AudioPlayer trapSound;
AudioPlayer cheeseSound;
AudioPlayer holyShitSound;
AudioPlayer fire;

void menuSetup() {
  blockX1 = width / 2 - BLOCK_WIDTH / 2;
  blockY1 = height / 4 - BLOCK_HEIGHT / 2;
  blockX2 = width / 2 - BLOCK_WIDTH / 2;
  blockY2 = height * 3 / 4 - BLOCK_HEIGHT / 2;

  fill(31, 12, 142);
  rect(0, 0, width / 2, height);

  fill(61, 149, 11);
  rect(width / 2, 0, width / 2, height);
}

void gameSetup() {
  // Координаты ракеток
  lPaddleX = 0;
  lPaddleY = height / 2 - PADDLE_HALF_HEIGHT;
  rPaddleX = width - PADDLE_WIDTH;
  rPaddleY = lPaddleY;

  // Начальная позиция шарика
  x = width / 2;
  y = height / 2;
}

void clockSetup() {
  xClock = width / 2;
  yClock = height * 9.3 / 10;
}

void crownSetup() {
  crownImage = loadImage("crown.png");
}

void fireSetup() {
  fireSprite = new Sprite("fire/fire", 2, ".png");
  fireWidth = width;
  

}

void medalSetup() {
  medalSprite = new Sprite("medal/medal", 6, ".png");
  medalX = width / 4;
  medalY = height / 2;
}

void textSetup() {
  textAlign(CENTER, CENTER);
  import javax.swing.*;
  gameFont1982 = createFont("BACKTO1982.TTF", 32);
  fontPixelHour = createFont("Pixelhour.ttf", 32);
  fontGG = createFont("GG.otf", 32);
}

void soundSetUp() {
  minim = new Minim(this);
  
  // Бонусы и эффекты 
  runSound = minim.loadFile("runSound.wav");
  ballHit = minim.loadFile("ballHit.wav");
  trapSound = minim.loadFile("trapSound.wav");
  cheeseSound = minim.loadFile("cheeseSound.wav");
  holyShitSound = minim.loadFile("holyShitSound.wav");
  fire = minim.loadFile("fire.wav");
}  
