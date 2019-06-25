class Cue {

  float x, y;
  float radius = 50;
  float angle = 0;
  float cueLength = 150;
  float speed = 0;
  float maxSpeed = 15;
  boolean hitWhiteBall = false;
  boolean increaseSpeed = true;

  Cue(Ball whiteBall) {
    this.x = whiteBall.x;
    this.y = whiteBall.y;
  }

  void display(Ball whiteBall) {
    x = whiteBall.x;
    y = whiteBall.y;

    if (drawCue) {
      pushMatrix();
      translate(whiteBall.x, whiteBall.y);
      rotate(angle);
      strokeWeight(1);
      stroke(255);
      line(whiteBall.radius + 40-width, 0, whiteBall.radius + 40 + cueLength, 0);
      strokeWeight(10);
      stroke(103, 2, 2);
      line(whiteBall.radius + 40, 0, whiteBall.radius + 40 + cueLength, 0);
      popMatrix();
    }
  }

  void speed() {
    if (mousePressed && drawCue()) {    
      if (increaseSpeed) {
        speed += 0.1;
      } else {
        speed -= 0.1;
      }
    }

    if (speed <= 0) {
      increaseSpeed = true;
    } else if (speed >= maxSpeed) {
      increaseSpeed = false;
    }

    float barWidth = map(speed, 0, maxSpeed, 0, 200);

    stroke(255);
    strokeWeight(1);
    noFill();
    rectMode(CORNER);
    rect(50, height-20, 200, 10);
    noStroke();
    fill(255, 0, 0);
    rect(50, height-20, barWidth, 10);
  }

  void rotateCue(Ball whiteBall) {
    float mousex = (mouseX-whiteBall.x) - (x-whiteBall.x); 
    float mousey = (mouseY-whiteBall.y) - (y-whiteBall.y);

    angle = atan2(mousey, mousex);
  }
}
