class Wave {
  
  float theta;
  
  Wave(float thetatemp) {
      
      theta = thetatemp;
    
  }
  
  void move() {
        // Increment theta (try different values for "angular velocity " here)
      theta += 0.02;
      color c = color(0,0,100);
      noStroke();
      fill(c);
      
  }

  void display() {
        float angle = theta;
        // A for loop is used to draw all the points along a sine wave (scaled to the pixel dimension of the window).
        for (int x = 0; x <= width; x += 10) {
            // Calculate y value based off of sine function
            float y = map(sin(angle), -1, 1, 0, height);
            // Draw an ellipse
            ellipse(x, y, 16, 16);
            // Increment angle
            angle += 0.1;
      }
  }
}
