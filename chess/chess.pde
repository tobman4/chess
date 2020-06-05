Board board;
board_controller controller;
PImage piec_sheet;
boolean DEBUG = true;

int[][] piec_list1 = {
  {0,1,1,0}, // pawn
  {0,1,1,1},
  {0,1,1,2},
  {0,1,1,3},
  {0,1,1,4},
  {0,1,1,5},
  {0,1,1,6},
  {0,1,1,7},
  //{0,0,1,8},
  //{0,0,1,9}, // pawn end
  
  {1,1,0,0}, // tower
  {1,1,0,7}, // tower end
  
  {2,1,0,1}, // bishop
  {2,1,0,6}, // bishop end
  
  {3,1,0,2}, // knigth
  {3,1,0,5}, // knigth end
  
  {4,1,0,3}, // king
  {5,1,0,4}, // queen
};

int[][] piec_list2 = {
  {0,0,6,0}, // pawn
  {0,0,6,1},
  {0,0,6,2},
  {0,0,6,3},
  {0,0,6,4},
  {0,0,6,5},
  {0,0,6,6},
  {0,0,6,7},
  //{0,0,1,8},
  //{0,0,1,9}, // pawn end
  
  {1,0,7,0}, // tower
  {1,0,7,7}, // tower end
  
  {2,0,7,1}, // bishop
  {2,0,7,6}, // bishop end
  
  {3,0,7,2}, // knigth
  {3,0,7,5}, // knigth end
  
  {4,0,7,4}, // king
  {5,0,7,3}, // queen
};

void setup() {
  
  size(480,480);
  
  piec_sheet = loadImage("sheet_noise_median_modified.jpg");
  
  board = new Board();
  
  controller = new board_controller(board);
  
  controller._place_array(piec_list1);
  controller._place_array(piec_list2);
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
