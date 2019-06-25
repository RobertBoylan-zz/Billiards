float spring = 0.05;
float friction = 0.01;
boolean drawCue = false;
boolean gameOver = false;
boolean firstBallPot = false;
boolean playerOneTurn = true;
boolean resetWhiteBall = false;
color playerOneColour;
color playerTwoColour;
ArrayList<Ball> ballList;
BilliardsTable table;
Cue cue;

void setup() {
  size(1000, 600);

  table = new BilliardsTable();
  ballList = new ArrayList<Ball>();

  ballList.add(new Ball(table.x-table.tableWidth/2+200, table.y, 0, 0, color(255))); // white
  ballList.add(new Ball(table.x+200, table.y, 0, 0, color(255, 0, 0))); // red 1
  ballList.add(new Ball(ballList.get(1).x+ballList.get(1).radius*2-5, ballList.get(1).y+ballList.get(1).radius, 0, 0, color(255, 255, 0))); // yellow 1
  ballList.add(new Ball(ballList.get(1).x+ballList.get(1).radius*2-5, ballList.get(1).y-ballList.get(1).radius, 0, 0, color(255, 0, 0))); // red 2
  ballList.add(new Ball(ballList.get(1).x+(ballList.get(1).radius*2-5)*2, ballList.get(1).y, 0, 0, color(0))); // black
  ballList.add(new Ball(ballList.get(4).x, ballList.get(4).y-ballList.get(4).radius*2, 0, 0, color(255, 255, 0))); // yellow 2
  ballList.add(new Ball(ballList.get(4).x, ballList.get(4).y+ballList.get(4).radius*2, 0, 0, color(255, 0, 0))); // red 3
  ballList.add(new Ball(ballList.get(6).x+ballList.get(6).radius*2-5, ballList.get(6).y+ballList.get(6).radius, 0, 0, color(255, 255, 0))); // yellow 3
  ballList.add(new Ball(ballList.get(6).x+ballList.get(6).radius*2-5, ballList.get(7).y-ballList.get(7).radius*2, 0, 0, color(255, 0, 0))); // red 4
  ballList.add(new Ball(ballList.get(6).x+ballList.get(6).radius*2-5, ballList.get(8).y-ballList.get(8).radius*2, 0, 0, color(255, 255, 0))); // yellow 4
  ballList.add(new Ball(ballList.get(6).x+ballList.get(6).radius*2-5, ballList.get(9).y-ballList.get(9).radius*2, 0, 0, color(255, 0, 0))); // red 5
  ballList.add(new Ball(ballList.get(4).x+(ballList.get(4).radius*2-5)*2, ballList.get(4).y, 0, 0, color(255, 0, 0)));
  ballList.add(new Ball(ballList.get(11).x, ballList.get(11).y-ballList.get(11).radius*2, 0, 0, color(255, 255, 0)));
  ballList.add(new Ball(ballList.get(12).x, ballList.get(12).y-ballList.get(12).radius*2, 0, 0, color(255, 0, 0)));
  ballList.add(new Ball(ballList.get(11).x, ballList.get(11).y+ballList.get(11).radius*2, 0, 0, color(255, 255, 0)));
  ballList.add(new Ball(ballList.get(14).x, ballList.get(14).y+ballList.get(14).radius*2, 0, 0, color(255, 0, 0)));

  cue = new Cue(ballList.get(0));
}

void draw() {
  background(0);

  table.display();
  
  if(firstBallPot){
    table.displayPlayerColours(playerOneColour, playerTwoColour);
  }
  
  drawCue = drawCue();

  for (int i = ballList.size() - 1; i >= 0; i--) {
    ballList.get(i).display();
    ballList.get(i).move(table);
    ballList.get(i).hitWithCue(cue);

    if (pocketBallCollision(ballList.get(i))) {
      if (ballList.get(i).colour == color(255)) {
        ballList.remove(i);
        resetWhiteBall = true;
      } else {
        potBlackBall(ballList.get(i));
        ballList.remove(i);
        break;
      }
      if (!firstBallPot) {
        firstBallPot = true;
        if (playerOneTurn) {
          if (ballList.get(i).colour == color(255, 0, 0)) {
            playerOneColour =  ballList.get(i).colour;
            playerTwoColour =  color(255, 0, 0);
          }
        } else {
          playerTwoColour =  ballList.get(i).colour;
        }
      }
    }

    for (int j = ballList.size() - 1; j >= 0; j--) {
      if (i != j) {
        ballList.get(i).collide(ballList.get(j));
      }
    }

    if (ballList.get(i).colour == color(255)) {
      cue.display(ballList.get(i));
      cue.rotateCue(ballList.get(i));
    }
  }

  cue.speed();
  resetWhiteBall();
  gameOver();
}

boolean pocketBallCollision(Ball ball) {
  if (table.pocketBallCollision(ball)) {
    return true;
  }
  return false;
}

boolean drawCue() {
  for (int i = ballList.size() - 1; i >= 0; i--) {
    if (abs(ballList.get(i).xVel) > 0 || abs(ballList.get(i).yVel) > 0) {
      return false;
    }
  }
  return true;
}

void potBlackBall(Ball ball) {
  if (ball.colour == color(0)) {
    if (ballList.size() > 2) {
      gameOver = true;
    } else {
      gameOver = true;
    }
  }
}

void resetWhiteBall() {
  if (resetWhiteBall && drawCue) {
    ballList.add(new Ball(table.x-table.tableWidth/2+200, table.y, 0, 0, color(255))); // white
    resetWhiteBall = false;
  }
}

void gameOver() {
  if (gameOver) {
    background(255, 0, 0);
  }
}

void mouseReleased() {
  if (drawCue()) {
    cue.hitWhiteBall = true;
  }
}
