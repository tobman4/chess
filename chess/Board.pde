
class Board  {
  Point pos = new Point(0,0);
  final int size = 10;
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
    println(this.Board[x][y]);
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
    println(wil_kill);
    if(curr.move_check(from, to,wil_kill,false) || force) {
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
  
  boolean is_jump_move(Point a, Point b) {
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
