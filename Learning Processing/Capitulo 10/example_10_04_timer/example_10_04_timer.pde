// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 10-4: Implementing a timer


Timer timer;



void setup() {
    size(200, 200);
    background(0);
    timer = new Timer(2000);
    timer.start();
}


void draw() {
    if (timer.isFinished()) {
        println("Ya pasaron 2 segundos!");
        background(random(255));
        timer.start();
    }

}
