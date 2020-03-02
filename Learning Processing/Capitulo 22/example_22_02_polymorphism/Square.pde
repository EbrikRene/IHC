// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 22-2: Polymorphism

class Square extends Shape {
  // Variables are inherited from the parent.
  // We could also add variables unique to the Square class if we so desire

  Square(float x_, float y_, float r_) {
    // If the parent constructor takes arguments then super() needs to pass in those arguments.
    super(x_,y_,r_); 
  }

    // Inherits jiggle() from parent
  void jiggle() {
    super.jiggle();
    // The Circle jiggles its size as well as its x,y location.
    r += random(-2,2); 
    r = constrain(r,0,100);
  }

  // The square overrides its parent for display.
  void display() {
    rectMode(CENTER);
    fill(175);
    stroke(0);
    rect(x,y,r,r);
  }
}
