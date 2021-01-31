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

// Шрифты
PFont font1982;
PFont fontGG;
PFont fontPixelHour;

// Изображения
PImage wallImage;
PImage backgroundImage;
PImage floorImage;

PImage heroImageFrontRight, heroImageFrontLeft;
PImage heroImageBackRight, heroImageBackLeft;
PImage heroImage;

PImage skeletonImageRight;
PImage skeletonImageLeft;

PImage doorLockedVertImage, doorOpenedVertImage;
PImage doorLockedHorImage, doorOpenedHorImage;

PImage keysImage;

PImage healthFullImage;
PImage healthHalfImage;
PImage healthEmptyImage;

PImage lavaImage;

PImage obsidianImage;

PImage waterBucketImage;

PImage gemImage;

PImage ogreImageLeft;
PImage ogreImageRight;

Sprite skullSprite;
Sprite exitSprite;
Sprite coinSprite;

// Звук
import ddf.minim.*;
 
Minim minim;
// Звуки по перемещению героя
AudioPlayer walkSound;

AudioPlayer pickUpCoinSound;
AudioPlayer pickUpGemSound;
AudioPlayer pickUpKey;

AudioPlayer lockedDoorSound;
AudioPlayer openDoorSound;

AudioPlayer enemyHurt;

// Фоновые звуи
AudioPlayer winScreenSound;
AudioPlayer defeatScreenSound;
AudioPlayer unityGameSound;

void soundSetUp() {
  minim = new Minim(this);
  
  unityGameSound = minim.loadFile("unityGameSound.wav");
  
  walkSound = minim.loadFile("walkSound.wav");
  
  pickUpCoinSound = minim.loadFile("pickUpCoin.wav");
  pickUpGemSound = minim.loadFile("pickUpGem.wav");
  pickUpKey = minim.loadFile("pickUpKey.wav");
  
  lockedDoorSound = minim.loadFile("lockedDoorSound.wav");
  openDoorSound = minim.loadFile("openDoorSound.wav");

  enemyHurt = minim.loadFile("enemyHurt.wav");
  
  winScreenSound = minim.loadFile("winScreenSound.wav");
  defeatScreenSound = minim.loadFile("defeatScreenSound.wav");
}

void textSetup() {
  font1982 = createFont("BACKTO1982.TTF", 32);
  fontGG = createFont("GG.otf", 32);
  fontPixelHour = createFont("Pixelhour.ttf", 32);
}

void imageSetup() {
  wallImage = loadImage("wall.jpeg");
  backgroundImage = loadImage("background.png");
  floorImage = loadImage("floor.png");

  heroImageFrontRight = loadImage("hero/hero0.png");
  heroImageFrontLeft = loadImage("hero/hero1.png");
  heroImageBackRight = loadImage("hero/hero3.png");
  heroImageBackLeft = loadImage("hero/hero2.png");

  skeletonImageRight = loadImage("skeleton/skeleton0.png");
  skeletonImageLeft = loadImage("skeleton/skeleton1.png");

  doorOpenedVertImage = loadImage("door/door0.png");
  doorLockedVertImage = loadImage("door/door1.png");
  doorOpenedHorImage = loadImage("door/door1.png");
  doorLockedHorImage = loadImage("door/door0.png");
  keysImage = loadImage("key.png");
  
  healthFullImage = loadImage("health/health0.png");
  healthHalfImage = loadImage("health/health1.png");
  healthEmptyImage = loadImage("health/health2.png");
  
  lavaImage = loadImage("lava.png");
  obsidianImage = loadImage("obsidian.png"); 
  waterBucketImage = loadImage("waterBucket.png");
  
  gemImage = loadImage("gem.png");
  
  ogreImageLeft = loadImage("ogre/ogre0.png");
  ogreImageRight = loadImage("ogre/ogre1.png");
  
  skullSprite = new Sprite("skull/skull", 2, ".png");
  coinSprite = new Sprite("coin/coin_", 8, ".png");
  exitSprite = new Sprite("portals/portals", 2, ".png");
}

void healthSetup() {
   healthXStart = 0;
   healthX = healthXStart;
   healthY = height - 70;
}

void fireworkSetup() {
  startFireworkCopyX = width / 2;
  startFireworkCopyY = height / 2;
}

void atackSystemSetup() {
  strokeWeight(6);
}
