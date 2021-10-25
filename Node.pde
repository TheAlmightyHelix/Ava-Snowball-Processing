class Node{
  private int vote;
  private int x,y,r;
  
  Node(int v, int x, int y, int r){
    this.vote = v;
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  void flip(){
    this.vote = (vote+1)%2;
  }
  
  int getVote(){
    return this.vote;
  }
  
  void drawNode(){
    noStroke();
    switch(vote){
      case 0: fill(#eeeeee); break;
      case 1: fill(#ff2211); break;
    }
    circle(x,y,r);
  }
  
  void drawFocus(){
    noFill();
    stroke(0);
    rect(x,y,r,r);
  }
  
  void drawSub(){
    noFill();
    stroke(0);
    circle(x,y,r);
  }
}
