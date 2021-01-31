void fire() {
  fireSprite.draw(fireX, height - fireHeight, fireWidth * 6, fireHeight);
  fireSprite.draw(fireX, height - fireHeight, fireWidth * 6, fireHeight);
  fireSprite.draw(fireX, height - fireHeight, fireWidth * 6, fireHeight);
  fire.play();
  fire.rewind();  
}
