class board_controller {
  
  Board playing_board;
  Point pos_a = null;
  Piec selected = null;
  boolean turn = false;
  
  board_controller(Board b) {
    this.playing_board = b;;
  }
  
  void get_input(int x, int y) {
    Point pos = this.playing_board.pixel_to_grid(x,y);
    Piec piec = this.playing_board.get_piec(pos);
    
    if(piec == selected) {
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
    } //<>//
  }
  
  boolean is_force_move() {
    println(keyPressed == true);
    return (keyPressed == true && keyCode == 70);
  }
  
}

void mousePressed() {
  controller.get_input(mouseX,mouseY);
}
