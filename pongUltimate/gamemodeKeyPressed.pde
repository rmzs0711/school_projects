void abilityKeyPressed() {
  // Сами способности
  int randomAbility = int(random(0, 3));
  if (key == 'x' &&
     lAbilityScore > 0 &&
     x < width && x > 0) {
    switch (randomAbility) {
    case 0: // МАСТЕР ЙОДА
      trapSound.play();
      trapSound.rewind();
      lAbilityScore -= 1;
      dx = -dx;
      break;
    case 1: // Скушал сыр
      cheeseSound.play();
      cheeseSound.rewind();
      lAbilityScore -= 1;
      lPaddleHeight += 10;
      break;
    case 2: // RUN
      //Звук подбора монет
      runSound.play();
      runSound.rewind();
      
      lAbilityScore -= 1;
      if (dx > 0) {
        dx += 10;
      } else {
        dx -= 10;
      }
      break;
    }
  } else if (keyCode == SHIFT &&
            rAbilityScore > 0 &&
             x < width &&
             x > 0) {
    switch (randomAbility) {
    case 0: // МАСТЕР ЙОДА
      trapSound.play();
      trapSound.rewind();
      rAbilityScore -= 1;
      dx = -dx;
      break;
    case 1: // Скушал сыр
      cheeseSound.play();
      cheeseSound.rewind();
      rAbilityScore -= 1;
      rPaddleHeight += 10;
      break;
    case 2: // RUN 
      // Звук
      runSound.play();
      runSound.rewind();
      
      rAbilityScore -= 1;
      if (dx > 0) {  
        dx += 10;
      } else {
        dx -= 10;
      }
      break;
    }
  }
}

void pauseKeyPressed() {
  if (key == ' ') {
    pastGamemode = gamemode;
    gamemode = 3;
    pastDX = dx;
    pastDY = dy;
    dx = 0;
    dy = 0;
  }
}

void restartKeyPressed() {
  if (keyCode == ENTER) {
    gamemode = 0;
    lScore = 0;
    rScore = 0;
    rAbilityScore = 1;
    lAbilityScore = 1;
    roundMinute = ROUND_MAX_MINUTE;
    x = width / 2;
    y = height / 2;
    dx = pastDX;
    dy = pastDY;
  }
}
