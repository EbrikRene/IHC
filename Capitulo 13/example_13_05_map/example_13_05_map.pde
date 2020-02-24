// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 13-4: Using map()

void setup() {
  size(480, 270);
}

void draw() {

  float r = map(mouseX, 0, width, 0, 255);
  float b = map(mouseY, 0, height, 255, 0);
  float g = map(mouseY, 0, height, 0, 255);
  background(r, g, b);
}
