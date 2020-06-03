
class Board  {
  Point pos = new Point(0,0);
  final int size = 8;
  final int pice_size = 60;
  
  private Piec[][] Board = new Piec[this.size][this.size];
  
  Board() {
    for(int i = 0; i < this.Board.length; i++) {
      for(int j = 0; j < this.Board[i].length; j++) {
        Board[i][j] = null;
      }
    }
  }
  
  void render() {
    boolean c = false;
    
    
    for(int i = 0; i < this.Board.length; i++) {
      
      c = i%2 == 1; // velg farge den skal starte på
      
      for(int j = 0; j < this.Board[i].length; j++) {
        
        if(c) {
          fill(255);
        } else {
          fill(0);
        }
        c = !c;
        rect(i*this.pice_size,j*this.pice_size,this.pice_size,this.pice_size);
        if(this.Board[i][j] != null) {
          this.Board[i][j].render();
        }
      }
    }
  }
  
  boolean place_piec(int x, int y, Piec p, boolean force) {
    if(this.Board[x][y] == null || force) {
      p.pos = new Point(x*this.pice_size,y*this.pice_size); 
      this.Board[x][y] = p;
      return true;
    } else {
      return false;
    }
  }
  
  boolean move_piec(Point from, Point to, boolean force) {
    Piec curr = this.Board[from.X][from.Y];
    
    boolean wil_kill = this.is_killing_move(to,from);
    boolean wil_jump = this.is_jump_move(to,from);
    
    if(DEBUG) {
      print("this move wil kill: ");
      println(wil_kill);
      print("this move wil jump: ");
      println(wil_jump);
      
      print("move from: ");
      from.DBG();
      print("\nmove to: ");
      to.DBG();
      println();
    }
    
    if(curr.move_check(from, to,wil_kill,wil_jump) || force) {
      curr.move(new Point(to.X*this.pice_size,to.Y*this.pice_size));
      this.Board[from.X][from.Y] = null;
      this.Board[to.X][to.Y] = curr;
    } else {
      return false; 
    }
    
    return true;
  }
  
  boolean is_killing_move(Point a, Point b) {
    return (this.Board[a.X][a.Y] != null && this.Board[b.X][b.Y] != null);
  }
  
  boolean is_jump_move(Point b, Point a) {
    int X_dif = a.X - b.X;
    int Y_dif = a.Y - b.Y;
    int[] cord = {a.X,a.Y}; //<>//
    
    if(X_dif == 0 || Y_dif == 0) { // ifi it is not a diagonal move
      int start,end,step,mark;
      if(X_dif != 0) {
        start = a.X;
        end = b.X;
        mark = 0;
      } else {
        start = a.Y;
        end = b.Y;
        mark = 1;
      }
      if(start > end) {
        step = -1;
      } else {
        step = 1;
      }
      
      //end = end - step;
      //start = start + step;
      
      for(int i = start; i != end; i += step) {
        cord[mark] = i;
        (new Point(cord[0],cord[1])).DBG();
        print(" = ");
        println(this.Board[cord[0]][cord[1]]);
        
         if(cord[0] == a.X && cord[1] == a.Y || cord[0] == b.X && cord[1] == b.Y) {
           println("is me or end");
         } else if(this.Board[cord[0]][cord[1]] != null) {
          return true;
        }
      }
    } else if(X_dif == Y_dif || -X_dif == Y_dif) {
      int start,end,step; //<>//
      int X_step;
      int Y_step;
      if(a.X < b.X) {
        X_step = 1;
      } else {
        X_step = -1;
      }
      if(a.Y < b.Y) {
        Y_step = 1;
      } else {
        Y_step = -1;
      }
      
      start = a.X;
      end = b.X;
      if(start > end) {
        step = -1;
      } else {
        step = 1;
      }
      for(int i = start; i != end-step; i += step) {
        cord[0] += X_step;
        cord[1] += Y_step;
        if(this.Board[cord[0]][cord[1]] != null) {
          return true;
        }
      }
    }
    return false;
  }
  
  Point pixel_to_grid(int x,int y) {
    int xr = floor(x/this.pice_size);
    int yr = floor(y/this.pice_size);
    
    if(yr > this.size && yr < this.size) {
      return new Point(-1,yr);
    } else if(yr > this.size && yr < this.size) {
      return new Point(xr,-1);
    }
    
    return new Point(xr,yr);
  }
  
  Piec get_piec(Point pos) {
    if(!(pos.X < 0 || pos.Y < 0 ||
    pos.X >this.size || pos.Y > this.size)) {
      
      return this.Board[pos.X][pos.Y];
    } else { 
      return null;
    }
  }
  
}
