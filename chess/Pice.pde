abstract class Piec {
  Point pos;
  boolean DBG = false;
  boolean team = true;
  PImage icon = loadImage("default.PNG");
  
  Piec(int x, int y) {
    this.pos = new Point(x,y);
    this.icon.resize(60,60);
  }
  
  void render() {
    image(this.icon,this.pos.X,this.pos.Y);
    if(this.DBG) {    
      fill(255,0,255,100);
      rect(this.pos.X,this.pos.Y,60,60);
    }  
  }
  
  void move(Point new_pos) {
    this.pos = new_pos.Copy();
  }
  
  
   abstract boolean move_check(Point from, Point to, boolean wil_kill, boolean wil_jump);
}

//////////////////////////////////////////////////////////////////////////////
///////////////////////////TOWER//////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////////////
///////////////////////////BISHOP//////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class bishop extends Piec {
  bishop(int x, int y) {
    super(x,y);
  }
  
  boolean move_check(Point from, Point to, boolean wil_kill, boolean wil_jump) {
    return false;
  }
}
      
