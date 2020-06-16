Board board;
board_controller controller;
PImage piec_sheet;
boolean DEBUG = false;

/*
  to place piec
  add item to a list below

   { piec_id, team, x_pos, y_pos }

  - piec_id = se code in /controller.pde > board_controller._place_array

  - team = 1 = white and 0 = black

  - x_pos = x in grid

  - y_pos = y in grid
*/


int[][] piec_list1 = {
  {0,1,1,0}, // pawn
  {0,1,1,1},
  {0,1,1,2},
  {0,1,1,3},
  {0,1,1,4},
  {0,1,1,5},
  {0,1,1,6},
  {0,1,1,7}, // pawn end
  
  {1,1,0,0}, // tower
  {1,1,0,7}, // tower end
  
  {2,1,0,1}, // bishop
  {2,1,0,6}, // bishop end
  
  {3,1,0,2}, // knigth
  {3,1,0,5}, // knigth end
  
  {4,1,0,3}, // king
  {5,1,0,4}, // queen
};


// black team
int[][] piec_list2 = {
  {0,0,6,0}, // pawn
  {0,0,6,1},
  {0,0,6,2},
  {0,0,6,3},
  {0,0,6,4},
  {0,0,6,5},
  {0,0,6,6},
  {0,0,6,7}, // pawn end
  
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
  
  size(700,480);
  
  piec_sheet = loadImage("sheet_animated.gif");
  
  board = new Board();
  
  controller = new board_controller(board);
  
  controller._place_array(piec_list1);
  controller._place_array(piec_list2);
}

void draw() {
  board.render();
  controller.render();
}

String get_time() {
  String out = "";
  out += hour();
  out += ":";
  out += second();
  out += ":";
  out += millis();
  return out;
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
  
  String to_SAN() {
    String y = str(8-this.Y);
    String x = str((char)(65+this.X));
    return x+y;
  }
}
