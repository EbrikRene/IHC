// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// An array to keep track of how often random numbers are picked.

float[] randomCounts;
Rect rect;

void setup() {
    size(400, 400);
    randomCounts = new float[20];
    rect = new Rect(randomCounts);
}

void draw() {
    background(255);
    // Pick a random number and increase the count
    rect.display();
}
