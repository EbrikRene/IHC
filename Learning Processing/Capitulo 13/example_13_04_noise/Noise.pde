class Noise {
  
  float time;
  float increment;
  
 Noise(float incrementtemp) {
    time = 0;
    increment = incrementtemp;
   
 }
  
  void display() {
    color c=color(0,255,0);
    float n = noise(time) * width;
    fill(c);
    ellipse(width/2, height/2, n, n);
    time += increment;
  }
}
