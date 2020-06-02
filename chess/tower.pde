class tower extends Piec {
  
  boolean first_move = true;
  int move_dir;
  
  
  tower(int x,int y) {
    super(x,y);
  }
  
  boolean move_check(Point from, Point to, boolean wil_kill, boolean wil_jump) {
    return (from.X == to.X && from.Y != to.Y) ||
           (from.X != to.X && from.Y == to.Y) &&
           !wil_jump && !wil_jump;
  }
}
