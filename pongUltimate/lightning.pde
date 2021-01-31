//void lightning(float xL, float yL, float endXL, float endYL, float stepL, float speedL) {
//  stroke(0, 0, 255);
//  strokeWeight(1);
//  final float ACCEPTABLE = 3;
//  float length = Float.POSITIVE_INFINITY;
//  while (length > ACCEPTABLE) {
//    float dxL = (endXL - xL);
//    float dyL = (endYL - yL);
//    length = sqrt(dxL * dxL + dyL * dyL);
//    dxL /= length;
//    dyL /= length;
//    dxL *= speedL;
//    dyL *= speedL;
    
//    float xStep = random(-stepL, stepL);
//    float yStep = random(-stepL, stepL);
//    float nextX = constrain(xL + dxL + xStep, 0, width - 1);
//    float nextY = constrain(yL + dyL + yStep, 0, height - 1);
//    line(xL, yL, nextX, nextY);
//    xL = nextX;
//    yL = nextY;
//  }
//}
