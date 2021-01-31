void clock() {
  stroke(255);
  strokeWeight(2);

  // Циферблат
  fill(0, 0, 0, 0);
  circle(xClock, yClock, CLOCK_SIZE * 2);

  // Стрелка
  endX = xClock + cos(radians(angle) - PI / 2) * CLOCK_SIZE;
  endY = yClock + sin(radians(angle) - PI / 2) * CLOCK_SIZE;
  line(xClock, yClock, endX, endY);
  noStroke();

  // Угол
  angle += PI / 31.8; 

  // Осталось минут
  fill(255, 0, 0);
  textFont(fontGG);
  textSize(CLOCK_SIZE);
  text(roundMinute, xClock, yClock);
  
  if (radians(angle) > 2 * PI) {
    angle = 0;
    if (roundMinute > 1) {
      roundMinute -= 1;
    } else {
      gamemode = 4;
      pastDX = dx;
      pastDY = dy;
      dx = 0;
      dy = 0;
    }
  }
}
