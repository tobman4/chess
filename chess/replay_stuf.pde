class Recorder { // need new name
  Point pos,size;
  
  ArrayList<String> move_list = new ArrayList<String>();
  
  Recorder(int x, int y, int w, int h) {
    this.pos = new Point(x,y);
    this.size = new Point(w-1,h);
  }
  
  void render() {
    noFill();
    stroke(255,0,255);
    textSize(25);
    
    rect(this.pos.X,this.pos.Y,this.size.X,this.size.Y);
    for(int i = this.move_list.size()-1; i >= 0; i--) { //<>//
      String curr = this.move_list.get(i);
      text(curr,this.pos.X+this.size.X/2,this.pos.Y+this.size.Y-25-i*25,100,100);
    }
  }
  
  void record_move(Point from, Point to) {
    String move = from.to_SAN() + " - " + to.to_SAN();
    this.move_list.add(move);
  }
  
}
