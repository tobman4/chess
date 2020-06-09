class board_controller {
  
  Board playing_board;
  Recorder rec;
  Point pos_a = null;
  Piec selected = null;
  boolean turn = true;
  boolean game_over = false;
  
  board_controller(Board b) {
    this.playing_board = b;
    
    int board_w = this.playing_board.piec_W*this.playing_board.size;
    rec = new Recorder(board_w,0,width-board_w,height);
  }
  
  void get_input(int x, int y) {
    Point pos = this.playing_board.pixel_to_grid(x,y);
    Piec piec = this.playing_board.get_piec(pos);
    
    if(this.game_over) {
      return;
    }
    
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
        this.rec.record_move(pos_a,pos);
        selected.DBG = false;
        pos_a = null;
        this.turn = !this.turn;
      }
    }
    if(find_winner() >= 0) {
      this.game_over = false;
    }
  }
  
  boolean is_force_move() {
    println(keyPressed == true);
    return (keyPressed == true && keyCode == 70);
  }
  
  int find_winner() {
    boolean t_king = false;
    boolean f_king = false;
    
    for(int i = 0; i < this.playing_board.Board.length; i++) {
      for(int j = 0; j < this.playing_board.Board[i].length; j++) {
        if(this.playing_board.Board[i][j] != null) {
          
          if(this.playing_board.Board[i][j].getClass().getName() == "chess$king" &&
             this.playing_board.Board[i][j].team == true) {
            t_king = true;
          } else if(this.playing_board.Board[i][j].getClass().getName() == "chess$king" &&
                    this.playing_board.Board[i][j].team == false) {
            f_king = true;
          }
        }
        
      }
    }
    
    if(!t_king) {
      print("The white king is dead");
      return 1;
    } else if(!f_king) {
      print("The black king is dead");
      return 0;
    }
    return -1;
  }
  
  void _place_array(int[][] arr) {
    for(int i = 0; i < arr.length; i++) {
      int type = arr[i][0];
      boolean team = arr[i][1] == 1;
      int x = arr[i][2];
      int y = arr[i][3];
      int w = this.playing_board.piec_W;
      int h = this.playing_board.piec_H;
      Piec p;
      
      switch(type) {
        case 0:
          p = new pawn(x,y,w,h,team);
          break;
        case 1:
          p = new tower(x,y,w,h,team);
          break;
        case 2:
           p = new bishop(x,y,w,h,team);
           break;
        case 3:
          p = new knigth(x,y,w,h,team);
          break;
        case 4:
          p = new king(x,y,w,h,team);
          break;
        case 5:
          p = new queen(x,y,w,h,team);
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
  
  void render() { 
   if(this.rec != null) {
     this.rec.render();
   }
  }
}

void mousePressed() {
  controller.get_input(mouseX,mouseY);
}
