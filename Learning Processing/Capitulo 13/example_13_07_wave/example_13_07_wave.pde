// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 13-7: Wave

// Starting angle
float theta = 0.0;
Wave wave, wave2, wave3;

void setup() {
  size(480, 270);
  wave = new Wave(theta);
  wave2 = new Wave(0.5);
  wave3 = new Wave(5);
}

void draw() {
  background(255);
  wave.move();
  wave.display();
  wave2.move();
  wave2.display();
  wave3.move();
  wave3.display();
}
