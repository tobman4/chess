class board_controller {
  
  Board playing_board;
  Point pos_a = null;
  Piec selected = null;
  boolean turn = true;
  
  board_controller(Board b) {
    this.playing_board = b;;
  }
  
  void get_input(int x, int y) {
    Point pos = this.playing_board.pixel_to_grid(x,y);
    Piec piec = this.playing_board.get_piec(pos);
    
    
    if(piec == selected && piec != null) {
      selected.DBG = false;
      pos_a = null;
      return;
    }
    
    if(piec != null && pos_a == null) {
      if(piec.team == this.turn) {
        pos_a = pos;
        selected = piec;
        selected.DBG = true;
      }
    } else if(pos_a != null) {
      if(this.playing_board.move_piec(pos_a,pos,false)) {
        selected.DBG = false;
        pos_a = null;
        this.turn = !this.turn;
      }
    }
  }
  
  boolean is_force_move() {
    println(keyPressed == true);
    return (keyPressed == true && keyCode == 70);
  }
  
  void _place_array(int[][] arr) {
    for(int i = 0; i < arr.length; i++) {
      int type = arr[i][0];
      boolean team = arr[i][1] == 1;
      int x = arr[i][2];
      int y = arr[i][3];
      Piec p;
      
      switch(type) {
        case 0:
          p = new pawn(x,y,team);
          break;
        case 1:
          p = new tower(x,y,team);
          break;
        case 2:
           p = new bishop(x,y,team);
           break;
        case 3:
          p = new knigth(x,y,team);
          break;
        case 4:
          p = new king(x,y,team);
          break;
        case 5:
          p = new queen(x,y,team);
          break;
          
        default:
          println("ERROR ON UNKNOWN PIEC!!!");
          print("ERROR ON INDEX: ");
          println(i);
          return;
      }
      
      this.playing_board.place_piec(x,y,p,true);
      
    }
  }
}

void mousePressed() {
  controller.get_input(mouseX,mouseY);
}
