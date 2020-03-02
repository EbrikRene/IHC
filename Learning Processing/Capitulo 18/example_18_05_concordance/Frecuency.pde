class Frecuency {
  IntDict concordance;
  
  
  Frecuency () {
   
 }
 
 void count(IntDict concordance) {
  // Display the text and total times the word appears
  int h = 20;
  String[] keys = concordance.keyArray();
 
  for (int i = 0; i < height/h; i++) {
    String word = keys[i];
    int count = concordance.get(word);

    fill(51);
    rect(0, i*20, count/4, h-4);
    fill(0);
    text(word + ": " + count, 10+count/4, i*h+h/2);
    stroke(0);
    
  }
  }
}
