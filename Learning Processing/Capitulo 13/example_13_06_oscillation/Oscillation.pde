class Oscillation {
float theta;


Oscillation(float thetatemp) {
  theta = thetatemp;
}

void oscillate()  {
        // With each cycle,
        // increment theta
        theta += 0.05;
}

void display() {
        float x = map(sin(theta), -1, 1, 0, 200);
        // Draw the ellipse at the
        // value produced by sine
        color c = color(255,178,0);
        fill(c);
        stroke(0);
        line(width/2, x, width/2, 0);
        ellipse(height/2, x, 16, 16);
}
}
