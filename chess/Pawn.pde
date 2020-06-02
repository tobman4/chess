class pawn extends Piec {
  
  boolean first_move = true;
  int move_dir;
  
  
  pawn(int x,int y) {
    super(x,y);
    if(x == 1) {
      this.move_dir = 1;
    } else {
      this.move_dir = -1;
    }
  }
  
  pawn(int x,int y, int move_dir) {
    super(x,y);
    this.move_dir = move_dir; 
  }
  
  void move(Point new_pos) {
    this.pos = new_pos.Copy();
    this.first_move = false;
  }
  
  boolean move_check(Point from, Point to, boolean wil_kill, boolean jump_pice) {
    if(from.X+this.move_dir == to.X && from.Y == to.Y && !wil_kill) {
      return true;
    } else if(from.X+(this.move_dir*2) == to.X && from.Y == to.Y && this.first_move && !wil_kill) {
      return true;
    } else if(from.X+this.move_dir == to.X && (to.Y == from.Y+1 || to.Y == from.Y-1) && wil_kill) {
      return true;
    }
    return false;
  }
}
