class Rect {
float randomCounts[];
  
  Rect(float random[]) {
    randomCounts = random;
  }
  
  void display() {
   
int index = int(random(randomCounts.length));
    randomCounts[index]++ ;
    // Draw a rectangle to graph results
    color c = color(0, 0, 255);
    stroke(0);
    fill(c);
    for (int x = 0; x < randomCounts.length; x++) {
        rect(x * 20, 0, 19, randomCounts[x]);
    }
  }
  
}
