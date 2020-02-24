// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com
// Example 10-6: Simple raindrop behavior
// Variables for drop location

Raindrop drop1;
Raindrop drop2;
Raindrop drop3;
float speed1 = 1;


void setup() {
  size(480, 270);
  background(0);
  drop1 = new Raindrop();

}

void draw() {
  background(255);
  drop1.display();
  drop1.move(speed1);
  // Display the drop
}
