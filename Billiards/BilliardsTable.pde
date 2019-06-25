class BilliardsTable {

  float x, y;
  float tableWidth, tableHeight;
  ArrayList<Pocket> pocketList;

  BilliardsTable() {
    x = width/2;
    y = height/2;

    tableWidth = width-200;
    tableHeight = height-150;

    pocketList = new ArrayList<Pocket>();

    pocketList.add(new Pocket(x-tableWidth/2+15, y-tableHeight/2+15));
    pocketList.add(new Pocket(x-tableWidth/2+15, y+tableHeight/2-15));
    pocketList.add(new Pocket(x, y-tableHeight/2+15));
    pocketList.add(new Pocket(x, y+tableHeight/2-15));
    pocketList.add(new Pocket(x+tableWidth/2-15, y-tableHeight/2+15));
    pocketList.add(new Pocket(x+tableWidth/2-15, y+tableHeight/2-15));
  }

  void display() {
    rectMode(CENTER);
    stroke(131, 38, 38);
    strokeWeight(30);
    fill(10, 108, 3);
    rect(x, y, width-200, height-150);
    
    for(Pocket pocket : pocketList) {
      pocket.display();
    }
  }
  
  boolean pocketBallCollision(Ball ball) {
    for(Pocket pocket : pocketList) {
      if(pocket.collisionWithBall(ball)) {
        return true;
      }
    }
    return false;
  }
  
  void displayPlayerColours(color playerOneColour, color playerTwoColour) {
   textSize(25);
   textAlign(CENTER);
   rectMode(CENTER);
   fill(255);
   text("Player One: ", 100, 40);
   fill(playerOneColour);
   rect(180, 30, 30,30);
   fill(255);
   text("Player Two: ", width-180, 40);
   fill(playerTwoColour);
   rect(width-100, 30, 30,30);
  }
  
}
