class UI { // need new name
  Point pos,size;
  
  ArrayList<String> move_list = new ArrayList<String>();
  
  UI(int x, int y, int w, int h) {
    this.pos = new Point(x,y);
    this.size = new Point(w-1,h);
  }
  
  void render() {
    noFill();
    stroke(255,0,255);
    rect(this.pos.X,this.pos.Y,this.size.X,this.size.Y);
  }
  
  void record_move(Point from, Point to) {
    
  }
  
}
