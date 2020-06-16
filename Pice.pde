abstract class Piec {
  Point pos,size;
  boolean DBG = false;
  boolean team = true;
  PImage icon = loadImage("default.PNG");
  
  Piec(int x, int y,int w, int h,boolean t) {
    this.pos = new Point(x,y);
    this.size = new Point(w,h);
    this.icon.resize(w,h);
    team = t;
  }
  
  void render() {
    noStroke();
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
  
  
  tower(int x, int y,int w, int h,boolean t) {
    super(x,y,w,h,t);
    int c = 0;
    if(!t) {
      c += 60;
    }
<<<<<<< HEAD:chess/Pice.pde
    icon = piec_sheet.get(60,c,60,60);
=======
    icon = piec_sheet.get(60,c,120,60);
>>>>>>> parent of b7ade41... mappe fix:chess/Pice.pde
  }
  
  boolean move_check(Point from, Point to, boolean wil_kill, boolean wil_jump) {
    return ((from.X == to.X && from.Y != to.Y) ||
           (from.X != to.X && from.Y == to.Y)) &&
           !wil_jump;
  }
}
//////////////////////////////////////////////////////////////////////////////
///////////////////////////BISHOP//////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class bishop extends Piec {
  bishop(int x, int y,int w, int h,boolean t) {
    super(x,y,w,h,t);
    int c = 0;
    if(!t) {
      c += 60;
    }
<<<<<<< HEAD:chess/Pice.pde
    icon = piec_sheet.get(180,c,60,60);
=======
    icon = piec_sheet.get(180,c,240,60);
>>>>>>> parent of b7ade41... mappe fix:chess/Pice.pde
  }
  
  boolean move_check(Point from, Point to, boolean wil_kill, boolean wil_jump) {
    int X_dif = from.X - to.X;
    int Y_dif = from.Y - to.Y;
    
    return ((X_dif == Y_dif) || (-X_dif == Y_dif)) && !wil_jump;
  }
}
//////////////////////////////////////////////////////////////////////////////
///////////////////////////KNIGTH//////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class knigth extends Piec {
  knigth(int x, int y,int w, int h,boolean t) {
    super(x,y,w,h,t);
    int c = 0;
    if(!t) {
      c += 60;
    }
<<<<<<< HEAD:chess/Pice.pde
    icon = piec_sheet.get(120,c,60,60);
=======
    icon = piec_sheet.get(120,c,180,60);
>>>>>>> parent of b7ade41... mappe fix:chess/Pice.pde
  }
  
  boolean move_check(Point from, Point to, boolean wil_kill, boolean wil_jump) {
    int X_dif = from.X - to.X;
    int Y_dif = from.Y - to.Y;
    
    boolean two_step = false;
    boolean one_step = false;
    
    if(X_dif == 1 || X_dif == -1) {
      one_step = !one_step;
    } else if(X_dif == 2 || X_dif == -2) {
      two_step = !two_step;
    }
    
    if(Y_dif == 1 || Y_dif == -1) {
      one_step = !one_step;
    } else if(Y_dif == 2 || Y_dif == -2) {
      two_step = !two_step;
    }
    
    return two_step && one_step;
  }
}

//////////////////////////////////////////////////////////////////////////////
///////////////////////////KING//////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class king extends Piec {
  king(int x, int y,int w, int h,boolean t) {
    super(x,y,w,h,t);
    int c = 0;
    if(!t) {
      c += 60;
    }
<<<<<<< HEAD:chess/Pice.pde
    icon = piec_sheet.get(300,c,60,60);
=======
    icon = piec_sheet.get(300,c,360,60);
>>>>>>> parent of b7ade41... mappe fix:chess/Pice.pde
  }
  
  boolean move_check(Point from, Point to, boolean wil_kill, boolean wil_jump) {
    int X_dif = from.X - to.X;
    int Y_dif = from.Y - to.Y;
    return (X_dif >= -1 && X_dif <= 1) && (Y_dif >= -1 && Y_dif <= 1);
  }
}
//////////////////////////////////////////////////////////////////////////////
///////////////////////////QUEEN//////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class queen extends Piec {
  queen(int x, int y,int w, int h,boolean t) {
    super(x,y,w,h,t);
    int c = 0;
    if(!t) {
      c += 60;
    }
<<<<<<< HEAD:chess/Pice.pde
    icon = piec_sheet.get(240,c,60,60);
=======
    icon = piec_sheet.get(240,c,300,60);
>>>>>>> parent of b7ade41... mappe fix:chess/Pice.pde
  }
  
  boolean move_check(Point from, Point to, boolean wil_kill, boolean wil_jump) {
    int X_dif = from.X - to.X;
    int Y_dif = from.Y - to.Y;
    
    if(wil_jump) {
      return false;
    }
    
    return (from.X == to.X && from.Y != to.Y) || // move only in Y
           (from.X != to.X && from.Y == to.Y) || // move only in X
           (X_dif == Y_dif) || (-X_dif == Y_dif);// move diagonally
  }
}
//////////////////////////////////////////////////////////////////////////////
///////////////////////////PAWN//////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class pawn extends Piec {
  
  boolean first_move = true;
  int move_dir;
  
  
  pawn(int x, int y,int w, int h,boolean t) {
    super(x,y,w,h,t);
    if(x == 1) {
      this.move_dir = 1;
    } else {
      this.move_dir = -1;
    }
    int sheet_pos = 60;
    int animation_length = 3;
    
    
    
  }
  
  void render() {
    
    int x = 60*(frameCount%3);
    this.icon = piec_sheet.get(x,0,60,60);
    image(this.icon,this.pos.X,this.pos.Y);
    if(this.DBG) {
      fill(255,0,255,100);
      rect(this.pos.X,this.pos.Y,60,60);
    }
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
