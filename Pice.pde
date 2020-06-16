abstract class Piec {
  Point pos,size,sprite_base;
  Point current_frame = null;
  boolean DBG = false;
  boolean team = true;
  PImage icon = loadImage("default.PNG");

  int frame_delay = 250; // change default frame delay
  int last_frame_change = -10;
  
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
  
  void renderV2() {   
    if(millis() > last_frame_change + frame_delay) {
      next_frame();
    }
    image(this.icon,this.pos.X,this.pos.Y);
    if(this.DBG) {
      fill(255,0,255,100);
      rect(this.pos.X,this.pos.Y,60,60);
    }
  }

  private void next_frame() {
    if(current_frame == null) { // i am lazy
      current_frame = sprite_base.Copy();
    }

    if(current_frame.X != 120 && current_frame.X != 300) {
      current_frame.X += 60;
    } else if(current_frame.X == 120) {
      current_frame.X = 0;
    } else if(current_frame.X == 300) {
      current_frame.X = 240;
    }

    this.icon = piec_sheet.get(current_frame.X,current_frame.Y,60,60);

    last_frame_change = millis();
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
      c += 240;
    }
    this.sprite_base = new Point(c,60);
    
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
      c += 240;
    }
    this.sprite_base = new Point(c,180);
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
      c += 240;
    }
    this.sprite_base = new Point(c,120);
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
      c += 240;
    }
    this.sprite_base = new Point(c,300);
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
      c += 240;
    }
    this.sprite_base = new Point(c,240);
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
    int c = 0;
    if(!t) {
      c += 240;
    }
    this.sprite_base = new Point(c,0);
    
    
    
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
