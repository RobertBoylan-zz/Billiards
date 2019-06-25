class Pocket {

  float x, y;
  float radius = 25;

  Pocket(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    stroke(0);
    strokeWeight(1);
    fill(0);
    ellipse(x, y, radius*2, radius*2);
  }

  boolean collisionWithBall(Ball ball) {
    if (dist(x, y, ball.x, ball.y) < radius) {
      return true;
    }
    return false;
  }
}
