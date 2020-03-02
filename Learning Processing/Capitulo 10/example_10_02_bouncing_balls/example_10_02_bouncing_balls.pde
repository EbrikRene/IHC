// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 10-2: Bouncing ball class

// Two ball variables
Ball ball1;
Ball ball2;
Ball ball3;

void setup() {
  size(480, 270);
  
  // Initialize balls
  ball1 = new Ball(64);
  ball2 = new Ball(32);
  ball3 = new Ball(16);
}

void draw() {
  background(255);
  
  // Move and display balls
  ball1.move();
  ball2.move();
  ball3.move();
  ball1.display();
  ball2.display();
  ball3.display();
}
