class Player {

  boolean playerTurn;
  int playerID;
  String colour;

  Player(boolean playerTurn, int playerID) {
    this.playerTurn = playerTurn;
    this.playerID = playerID;
  }

  void setColour(String ballColour) {
    colour = ballColour;
  }
}
