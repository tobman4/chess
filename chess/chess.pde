Board board;
board_controller controller;
boolean DEBUG = true;

void setup() {
  
  size(600,600);
  
  board = new Board();
  
  for(int i = 0; i < board.size; i++) {
    Piec p1 = new tower(1,1);
    Piec p2 = new tower(8,1);
    
    p1.team = true;
    p2.team = false;
    
    board.place_piec(1,i,p1,false);
    board.place_piec(8,i,p2,false);
    
  }
  
  controller = new board_controller(board);
}

void draw() {
  board.render();
}

class Point {
  int X,Y;
  
  Point(int x,int y) {
    this.X = x;
    this.Y = y;
  }
  
  Point Copy() {
    return new Point(this.X,this.Y);
  }
  
  void DBG() {
    print("X: ");
    print(this.X);
    print("Y: ");
    print(this.Y);
  }
}
