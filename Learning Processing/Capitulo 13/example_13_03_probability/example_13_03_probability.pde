RandomColor circles;


void setup() {
    size(200, 200);
    background(255);
    noStroke();
    circles = new RandomColor(0.5,0.3,0.2);
}

void draw() {
    float num = random(1);
    circles.drawcircles(num);
}
