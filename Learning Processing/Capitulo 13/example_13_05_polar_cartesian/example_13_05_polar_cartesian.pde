// A polar coordinate
Cartesian cartesiana;

void setup() {
    size(200, 200);
    background(255);
    cartesiana = new Cartesian(0, 0);
}

void draw() {
  cartesiana.display();  
}
