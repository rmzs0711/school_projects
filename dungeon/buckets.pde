int bucketsCount = 0;

//Рисование вёдер с водой
void drawBucketsCount() {
  textAlign(LEFT,CENTER);
  textFont(fontGG);
  textSize(40);
  fill(0, 0, 200);
  
  if (bucketsCount > 0) {
    fill(255, 225, 0);
    image(waterBucketImage, width - 140, height - 100, 60, 60);
    text(": " + bucketsCount, width - 90, height - 70);
  }
}
