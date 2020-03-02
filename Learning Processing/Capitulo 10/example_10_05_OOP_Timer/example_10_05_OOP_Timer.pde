// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 10-5: Object-oriented timer

Timer timer;

void setup() {
  size(200, 200);
  background(255);
  timer = new Timer(1000);
  timer.start();
}

void draw() {
  if (timer.isFinished()) {
    background(random(255));
    timer.start();
  }
}
