class Cartesian {
    
float r;
float theta;

  Cartesian(float rtemp, float thetatemp) {
     r = rtemp;
     theta = thetatemp;
  }
    
    void display() {
        float x = r * cos(theta);
        float y = r * sin(theta);
        color c = color(255,0,0);
        noStroke();
        fill(c);
        ellipse(x + width/2, y + height/2, 8, 8); 
        // Increment the angle
        theta += 0.02;
        r+= 0.08;
    }
    
}
