void setup()
{
  noStroke();
  background(255);
  colorMode(HSB, 200, 1, 1);  // 1
}

void draw()
{
  fill(dist(pmouseX, pmouseY, mouseX, mouseY), 1, 1);  // 2
  ellipse(mouseX, mouseY, mouseX-pmouseX, mouseY-pmouseY);
}
