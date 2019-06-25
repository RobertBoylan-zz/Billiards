class Ball {

  float x, y;
  float xVel= 0;
  float yVel = 0;
  float radius = 15;
  color colour;

  Ball(float x, float y, float xVel, float yVel, color colour) {
    this.x = x;
    this.y = y;
    this.xVel = xVel;
    this.yVel = yVel;
    this.colour = colour;
  }

  void move(BilliardsTable table) {
    x += xVel;
    y += yVel;

    if (abs(xVel) > 0) {
      if (xVel > 0) {
        xVel -= friction;
      } else if (xVel < 0) {
        xVel += friction;
      }
    }
    if (abs(yVel) > 0) {
      if (yVel > 0) {
        yVel -= friction;
      } else if (yVel < 0) {
        yVel += friction;
      }
    }

    if (x + radius > table.x+table.tableWidth/2-15) {
      x = table.x+table.tableWidth/2-15-radius;
      xVel *= -1;
    } else if (x - radius < table.x-table.tableWidth/2+15) {
      x = table.x-table.tableWidth/2+15+radius;
      xVel *= -1;
    }
    if (y + radius > table.y+table.tableHeight/2-15) {
      y = table.y+table.tableHeight/2-15-radius;
      yVel *= -1;
    } else if (y - radius < table.y-table.tableHeight/2+15) {
      y = table.y-table.tableHeight/2+15+radius;
      yVel *= -1;
    }

    if (abs(xVel) < 0.01) {
      xVel = 0;
    }
    if (abs(yVel) < 0.01) {
      yVel = 0;
    }
  }

  void display() {
      fill(colour);
      noStroke();
      ellipse(x, y, radius*2, radius*2);
  }

  void hitWithCue(Cue cue) {
    if (colour == color(255) && cue.hitWhiteBall) {
      xVel = -cos(cue.angle)*cue.speed;
      yVel = -sin(cue.angle)*cue.speed;

      cue.hitWhiteBall = false;
      cue.speed = 0;
    }
  }

  void collide(Ball ball) {
    float dx = ball.x - x;
    float dy = ball.y - y;
    float distance = sqrt(dx*dx + dy*dy);
    float minDist = ball.radius + radius;

    if (distance < minDist && (abs(xVel) > 0 || abs(yVel) > 0 || abs(ball.xVel) > 0 || abs(ball.yVel) > 0)) { 
      float angle = atan2(dy, dx);
      float targetX = x + cos(angle) * minDist;
      float targetY = y + sin(angle) * minDist;
      float ax = (targetX - ball.x) * spring;
      float ay = (targetY - ball.y) * spring;
      xVel -= ax;
      yVel -= ay;
      ball.xVel += ax;
      ball.yVel += ay;
    }
  }
}
