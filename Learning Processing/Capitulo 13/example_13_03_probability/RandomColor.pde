class RandomColor {
  
    float red_prob;
    float green_prob;
    float blue_prob;
    float num = random(1);
  
  RandomColor(float c1, float c2, float c3) {
    red_prob = c1;
    green_prob = c2;
    blue_prob = c3;
  }
  
  void drawcircles(float num) {
    
    if (num < red_prob) {
        fill(255, 53, 2, 150);
    } else if (num < green_prob + red_prob) {
        fill(156, 255, 28, 150);
    } else {
        fill(10, 52, 178, 150);
    }
    // Now draw that circle!
    ellipse(random(width), random(height), 64, 64);
  
  }
  
}
