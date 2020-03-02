Oscillation oscillation;

void setup() {
    size(200, 200);
    oscillation = new Oscillation(0);
}

void draw() {
    background(255);
    oscillation.oscillate();
    oscillation.display();
}
