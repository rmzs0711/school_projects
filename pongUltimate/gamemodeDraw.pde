void menuDraw() {
  textFont(gameFont1982);
  noStroke();
  fill(31, 12, 142);
  rect(0, 0, width / 2, height);

  fill(61, 149, 11);
  rect(width / 2, 0, width / 2, height);

  // Название игры
  textFont(fontGG);
  textSize(100);
  fill(248, 252, 0);
  text("PONG ULTIMATE", width / 2, height / 2);

  //1 VS 1
  stroke(255);
  strokeWeight(3);
  fill(61, 149, 11); 
  rect(blockX1, blockY1, BLOCK_WIDTH / 2, BLOCK_HEIGHT, 50, 0, 0, 50);
  fill(31, 12, 142); 
  rect(blockX1 + BLOCK_WIDTH / 2, blockY1, BLOCK_WIDTH / 2, BLOCK_HEIGHT, 0, 50, 50, 0);

  // 1 VS AI
  fill(255, 175, 13);
  rect(blockX2, blockY2, BLOCK_WIDTH, BLOCK_HEIGHT, 50);
  noStroke();

  textFont(gameFont1982);
  fill(255);
  textSize(35);
  text("1 VS 1", blockX1 + BLOCK_WIDTH / 2, blockY1 + BLOCK_HEIGHT / 2); //ПЕРВЫЙ БЛОК
  text("1 VS AI", blockX2 + BLOCK_WIDTH / 2, blockY2 + BLOCK_HEIGHT / 2); //ВТОРОЙ БЛОК
  if (mouseX >= blockX1 &&
     mouseX <= blockX1 + BLOCK_WIDTH &&
     mouseY >= blockY1 &&
     mouseY <= blockY1 + BLOCK_HEIGHT &&
     mousePressed && 
     (mouseButton == LEFT)) {
    gamemode = GAME1VS1_GAMEMODE;

    lName = JOptionPane.showInputDialog("Введите имя первого/левого игрока");
    rName = JOptionPane.showInputDialog("Введите имя второго/правого игрока");
  } else if (mouseX >= blockX2 &&
            mouseX <= blockX2 + BLOCK_WIDTH &&
            mouseY >= blockY2 &&
            mouseY <= blockY2 + BLOCK_HEIGHT &&
            mousePressed && 
            (mouseButton == LEFT)) {
    gamemode = GAMEAI_GAMEMODE;

    lName = JOptionPane.showInputDialog("Введите имя первого/левого игрока"); 
    rName = "CHAPPIE";
  }
}

void gameDraw1VS1() {
  // Игровое поле
  fill(31, 12, 142); 
  rect(0, 0, width / 2, height);

  fill(61, 149, 11); 
  rect(width / 2, 0, width / 2, height);

  // Ракетки
  fill(31, 12, 142); // left Paddle
  rect(rPaddleX, rPaddleY, PADDLE_WIDTH, rPaddleHeight, 50);

  fill(61, 149, 11); //right Paddle
  rect(lPaddleX, lPaddleY, PADDLE_WIDTH, lPaddleHeight, 50);

  // Имена игроков
  textFont(gameFont1982);
  textSize(60);
  fill(200, 200, 0, 230);
  text(lName, width / 6, height / 30);
  text(rName, width * 5 / 6, height / 30);

  // Линия по середине
  stroke(255);
  strokeWeight(10);
  line(width / 2, height * 1 / 6, width / 2, height * 5 / 6);
  noStroke();

  // Окрас шарика, счёта и ракеток
  fill(255);

  // Шарик и его движение
  ellipse(x, y, DIAMETER, DIAMETER);
  x += dx;
  y += dy;

  // Счёт
  textFont(gameFont1982);
  textSize(100);
  text(lScore, SCORE_MARGIN_SIDE, SCORE_MARGIN_TOP);
  text(rScore, width - SCORE_MARGIN_SIDE, SCORE_MARGIN_TOP);
  text(":", width / 2, SCORE_MARGIN_TOP);

  // Отскок от стенок
  if (y > height - RADIUS || y < RADIUS) {
    dy = -dy;
    ballHit.play();
    ballHit.rewind();
  }

  // Отскок от ракеток
  if (x + RADIUS >= rPaddleX  &&
     x + RADIUS <= rPaddleX + PADDLE_WIDTH + 20 &&
     y + RADIUS >= rPaddleY &&
     y - RADIUS <= rPaddleY + rPaddleHeight) {       
      if (x + cos(0) * RADIUS <= rPaddleX &&
         rPaddleX <= x + cos(PI / 2) * RADIUS &&
         y + sin(0) * RADIUS <= rPaddleY &&
         rPaddleY <= y + sin(PI / 2) * RADIUS &&
         (gamemode == GAME1VS1_GAMEMODE || gamemode == GAMEAI_GAMEMODE)) { // Верхний угол правой ракетки
        dy = -1;
        dx = -dx - 6;
      } else if (x + cos(0) * RADIUS <= rPaddleX &&
                rPaddleX <= x + cos(PI / 2) * RADIUS &&
                y - sin(0) * RADIUS <= rPaddleY &&
                rPaddleY <= y - sin(PI / 2) * RADIUS &&
                (gamemode == GAME1VS1_GAMEMODE || gamemode == GAMEAI_GAMEMODE)) { // Нижний угол правой ракетки
        dy = 1;
        dx = -dx - 6;
      } else {
        dx = -dx; // Обычный отскок
      }
      ballHit.play();
      ballHit.rewind();
  } else if (x - RADIUS <= lPaddleX + PADDLE_WIDTH &&
    x - RADIUS >= lPaddleX - 20 && 
    y + RADIUS >= lPaddleY &&
    y - RADIUS <= lPaddleY + lPaddleHeight) {
      if (x - cos(0) * RADIUS <= rPaddleX &&
         rPaddleX <= x - cos(PI / 2) * RADIUS &&
         y + sin(0) * RADIUS <= rPaddleY &&
         rPaddleY <= y + sin(PI / 2) * RADIUS &&
         (gamemode == GAME1VS1_GAMEMODE || gamemode == GAMEAI_GAMEMODE)) { // Верхний угол левой ракетки
        dy = -1;
        dx = -dx + 6;
      } else if (x - cos(0) * RADIUS <= rPaddleX &&
                rPaddleX <= x - cos(PI / 2) * RADIUS &&
                y - sin(0) * RADIUS <= rPaddleY &&
                rPaddleY <= y - sin(PI / 2) * RADIUS &&
                (gamemode == GAME1VS1_GAMEMODE || gamemode == GAMEAI_GAMEMODE)) { // Нижний угол левой ракетки
        dy = 1;
        dx = -dx + 6;
      } else {
        dx = -dx;
      }
      ballHit.play();
      ballHit.rewind();
      
    // Конец раунда
  } else if (x > width + DELAY_DISTANCE) {
    x = width / 2;
    y = height / 2;
    lScore++;
    dy = int(random(-10, 11));
    if (dy == 0) {
      while (dy == 0) {
        dy = int(random(-10, 11));
      }
    }
    dx = int(random(-10, -3));
    if ( dy >= - 8 && dy <= 8) {
      dx = int(random(-16, -12));
    }
  } else if (x < 0 - DELAY_DISTANCE) {
    x = width / 2;
    y = height / 2;
    rScore++;
    dy = int(random(-10, 10));
    if (dy == 0) {
      while (dy == 0) {
        dy = int(random(-10, 11));
      }
    }
    dx = int(random(4, 11));
    if ( dy >= - 8 && dy <= 8) {
      dx = int(random(13, 17));
    }
  }

  // 2 игрока, движение ракеток
  if (keyPressed) {
    if (key == 'w' && lPaddleY > 0) {
      lPaddleY -= lPaddleDY;
    } else if (key == 's' &&
              lPaddleY + lPaddleHeight < height) {
      lPaddleY += lPaddleDY;
    }
    if (keyCode == UP &&
       rPaddleY > 0 &&
       gamemode == GAME1VS1_GAMEMODE) {
      rPaddleY -= rPaddleDY;
    } else if (keyCode == DOWN &&
              rPaddleY + rPaddleHeight < height &&
              gamemode == GAME1VS1_GAMEMODE) {
      rPaddleY += rPaddleDY;
    }
  }
  // FIRST AID
  if (lScore - rScore == 4 && bonus == 0) {
    holyShitSound.play();
    holyShitSound.rewind();
    
    rPaddleHeight += 40;
    bonus++;
  } else if (lScore - rScore == 1 && bonus >= 1) {    
    rPaddleHeight -= 40;
    bonus--;
  } else if (rScore - lScore == 4 && bonus == 0) {
    holyShitSound.play();
    holyShitSound.rewind();
    
    lPaddleHeight += 40;
    bonus++;
  } else if (rScore - lScore == 1 && bonus >= 1) {
    lPaddleHeight -= 40;
    bonus--;
  }

  // Магический шар способностей
  if (startAbility < 1) {
    xAbility = int(random(width / 4, width * 3 / 4));
    yAbility = int(random(ABILITY_HEIGHT, height - ABILITY_HEIGHT));
    startAbility += 1;
  }
  if (colA < 50) {
    fill(colR, colG, colB);
    rect(xAbility, yAbility, ABILITY_WIDTH, ABILITY_HEIGHT, 50);
    colA++;
  } else {
    colA = 0;
    colR = random(255);
    colG = random(255);
    colB = random(255);
  }

  // Счёт способностей
  fill(255);
  textFont(fontGG);
  textSize(60);
  if (x + RADIUS >= xAbility &&
     x + RADIUS <= xAbility + ABILITY_WIDTH &&
     (y + RADIUS >= yAbility || y - RADIUS >= yAbility) &&
     (y + RADIUS <= yAbility + ABILITY_HEIGHT ||
     y - RADIUS <= yAbility + ABILITY_HEIGHT)) {
    startAbility -= 1;
    if (dx < 0) {
      rAbilityScore += 1;
    } else if (dx > 0) {
      lAbilityScore += 1;
    }
  }
  if (lAbilityScore > 0) {
    text(lAbilityScore, width / 12, height / 9 + 40);
  }
  if (rAbilityScore > 0) {
    text(rAbilityScore, width * 11 / 12, height / 9 + 40);
  }
}
  
// Интеллект AI
void gameDrawAI() {
  if (rPaddleY > y - RADIUS &&
     rPaddleY > 0 &&
     dx > 0) {
    rPaddleY -= AIPaddleDY;
  } else if (rPaddleY < y + RADIUS &&
    rPaddleY + rPaddleHeight < height &&
    dx > 0) {
    rPaddleY += AIPaddleDY;
  }
}

// Пауза
void pauseDraw() {
  // Игровое поле
  fill(31, 12, 142); 
  rect(0, 0, width / 2, height);

  fill(61, 149, 11); 
  rect(width / 2, 0, width / 2, height);

  // Ракетки
  fill(31, 12, 142); // left Paddle
  rect(rPaddleX, rPaddleY, PADDLE_WIDTH, rPaddleHeight, 50);

  fill(61, 149, 11); //right Paddle
  rect(lPaddleX, lPaddleY, PADDLE_WIDTH, lPaddleHeight, 50);

  // Имена игроков
  textFont(gameFont1982);
  textSize(60);
  fill(200, 200, 0, 230);
  text(lName, width / 6, height / 30);
  text(rName, width * 5 / 6, height / 30);

  // Линия по середине
  stroke(255);
  strokeWeight(10);
  line(width / 2, height * 1 / 6, width / 2, height * 5 / 6);
  noStroke();

  // Окрас шарика, счёта и ракеток
  fill(255);

  // Шарик и его движение
  ellipse(x, y, DIAMETER, DIAMETER);
  x += dx;
  y += dy;

  // Счёт
  textFont(gameFont1982);
  textSize(100);
  text(lScore, SCORE_MARGIN_SIDE, SCORE_MARGIN_TOP);
  text(rScore, width - SCORE_MARGIN_SIDE, SCORE_MARGIN_TOP);
  text(":", width / 2, SCORE_MARGIN_TOP);

  // Счёт способностей
  textFont(fontGG);
  textSize(60);
  fill(255);
  if (lAbilityScore > 0) {
    text(lAbilityScore, width / 12, height / 9);
  }
  if (rAbilityScore > 0) {
    text(rAbilityScore, width * 11 / 12, height / 9);
  }

  fill(255, 0, 0);
  rect(blockX1, blockY1, BLOCK_WIDTH, BLOCK_HEIGHT, 50); // ВЕРХНИЙ

  fill(0, 255, 0);
  rect(blockX2 - 100, blockY2, BLOCK_WIDTH * 2, BLOCK_HEIGHT, 50); // НИЖНИЙ

  fill(216, 0, 250);
  rect(0, height / 2 - BLOCK_WIDTH / 2, width, BLOCK_HEIGHT * 2);

  textFont(fontGG);
  textSize(40);
  fill(0, 0, 255);
  text("ARE U SURE, THAT U WANT", width / 2, height / 2 - 30);
  text("TO LEAVE THIS AMAZING GAME?", width / 2, height / 2 + 30);

  fill(255);
  textSize(50);
  text("YES", blockX1 + BLOCK_WIDTH / 2, blockY1 + BLOCK_HEIGHT / 2);
  textSize(37);
  text("5 more min", blockX2 + BLOCK_WIDTH / 2, blockY2 + BLOCK_HEIGHT / 2);

  // Закрыть паузу
  if (mouseX >= blockX1 &&
     mouseX <= blockX1 + BLOCK_WIDTH &&
     mouseY >= blockY1 &&
     mouseY <= blockY1 + BLOCK_HEIGHT &&
     mousePressed && 
    (mouseButton == LEFT)) {
    exit();
  } else if (mouseX >= blockX2 &&
            mouseX <= blockX2 + BLOCK_WIDTH &&
            mouseY >= blockY2 &&
            mouseY <= blockY2 + BLOCK_HEIGHT &&
            mousePressed && 
            (mouseButton == LEFT)) {
    gamemode = pastGamemode;
    dx = pastDX;
    dy = pastDY;
  }
}

void winScreenDraw() {
  background(0, 0, 0, 20);
  fill(255, 0, 0);
  textFont(fontPixelHour);
  textSize(200);
  text("GAME OVER", width / 2, height / 6);

  textSize(80);
  fill(255);
  if (lScore > rScore) {
    text(lName, width / 2, height / 2);
    text("WON", width / 2, height / 2 + 140);
  } else if (rScore > lScore) {
    text(rName, width / 2, height / 2);
    text("WON", width / 2, height / 2 + 140);
  } else {
    text("DRAW", width / 2, height / 2);
  }
  fire();
  medal();
  crown();
}
