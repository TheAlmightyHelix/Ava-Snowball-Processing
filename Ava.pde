int x,y,r;
int t;
int sampleSize, polls;
Node[][] world;
int mouseState;
ArrayList<Float> ratios = new ArrayList<Float>();

void setup(){
  sampleSize = 17;
  polls = 1000;
  
  x = y = 100;
  r = 5;
  int fps = 10;
  
  size(680,650);
  frameRate(fps);
  mouseState=0;
  t = 0;
  
  ellipseMode(CORNER);
  textFont(createFont("Optima", 16));
  
  
  world = new Node[x][y];
  for(int i=0; i<x; i++){
    for (int j=0; j<y; j++){
      world[i][j] = new Node((int)random(2), i*r, j*r, r);
      world[i][j].drawNode();
    }
  }

}

void mousePressed() {
  if(mouseState%2==0)
    noLoop();
  else
    loop();
   
  mouseState++;
}

void keyPressed(){
  redraw();
}

void draw(){
  background(100);
  
  int[] count = {0, 0};
  
  
  for(Node[] row : world){
    for(Node n: row){
      if(n.getVote()==0) count[0]++;
      else count[1]++;
      
      n.drawNode();
    }
  }
  
  for(int c = 0; c < polls; c++){
    randomSample((int)random(x), (int)random(y), sampleSize);
    //sampleNeighors((int)random(x), (int)random(y));
  }
  
  float ratio = 100*count[0]/(x*y);
  ratios.add(ratio);

  fill(255);
  text("round "+t,x*r+5,20);
  text("white: "+ratio+"%",x*r+5,40);
  
  stroke(200);
  text("100%",2,555);
  line(50,550,650,550);
  noStroke();
  int strokes = 0;
  for(float r: ratios){
    rect(10+strokes*3, 650, 3, -r);
    strokes++;
  }
  
  //saveFrame("output/####.png");
  
  t++;
}








void sampleNeighors(int i, int j){
  Node node = world[i][j];
  int red = 0;
  int white = 0;
  
  // poll neighbors
  for(int m=-1; m<2; m++){
    for(int n=-1; n<2; n++){
      //if(m==0 && n==0) continue;
      if(world[(i+m+x)%x][(j+n+y)%y].getVote()==0) {
        white++;
      }
      else if(world[(i+m+x)%x][(j+n+y)%y].getVote()==1){
        red++;
      } 
    }
  }
  
  if(node.getVote()==0 && red > white) node.flip();
  if(node.getVote()==1 && red < white) node.flip();
  
  //node.drawNode();
}

void randomSample(int i, int j, int size){
  Node node = world[i][j];
  int[] self = {i,j};
  int red = 0;
  int white = 0;
   
  node.drawFocus();
  
  int c = 0;
  ArrayList<int[]> samples = new ArrayList<int[]>();
  while(c < size){
    int[] coord = {(int)random(x),(int)random(y)};
    
    // eliminate duplicates and self
    if(samples.contains(coord) && coord!=self) continue;
    
    // circle samples
    //world[coord[0]][coord[1]].drawSub();
    
    if(world[coord[0]][coord[1]].getVote()==0) {
      white++;
    }
    else if(world[coord[0]][coord[1]].getVote()==1){
      red++;
    } 
     
    samples.add(coord);
    c++;
  }
  
  if(node.getVote()==0 && red > white) node.flip();
  if(node.getVote()==1 && red < white) node.flip();
  
  //node.drawNode();
}
