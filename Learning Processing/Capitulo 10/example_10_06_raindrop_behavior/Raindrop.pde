class Raindrop { 
 float x1, y1, x2, y2, x3, y3; 
  
  Raindrop(){
    x1 = width/2;
    y1 = 0;
    x2 = width/3;
    y2 = 0;
    x3 = width/4;
    y3 = 0;
  }
  
  void display() {
      fill(50, 100, 150);
      noStroke();
      ellipse(x1, y1, 16, 16);
      fill(50, 100, 150);
      noStroke();
      ellipse(x2, y2, 16, 16);
      fill(50, 100, 150);
      noStroke();
      ellipse(x3, y3, 16, 16);
  }
  
  void move(float factor){
      y1 += factor ; 
      y2 += factor ;
      y3 += factor ;
  }
}
