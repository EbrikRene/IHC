Noise noise;
float increment = 0.02;

void setup() {
    size(200, 200);
    noise = new Noise(increment);
}

void draw() {
    background(255);
    noise.display();
}
