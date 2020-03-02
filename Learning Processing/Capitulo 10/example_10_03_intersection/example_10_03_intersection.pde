// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 10-3: Bouncing ball with intersection

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

  if (ball1.intersect(ball2)) { // New! An object can have a function that takes another object as an argument. This is one way to have objects communicate. In this case they are checking to see if they intersect.
    ball1.highlight();
    ball2.highlight();
  }
  if (ball2.intersect(ball3)) { // New! An object can have a function that takes another object as an argument. This is one way to have objects communicate. In this case they are checking to see if they intersect.
    ball2.highlight();
    ball3.highlight();
  }
  if (ball3.intersect(ball1)) { // New! An object can have a function that takes another object as an argument. This is one way to have objects communicate. In this case they are checking to see if they intersect.
    ball3.highlight();
    ball1.highlight();
  }
  ball1.display();
  ball2.display();
  ball3.display();
}
