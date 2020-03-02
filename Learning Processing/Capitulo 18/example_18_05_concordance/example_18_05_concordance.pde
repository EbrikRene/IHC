// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 18-6: Analyzing Text

String[] allwords;    // The array to hold all of the text
String url = "http://www.gutenberg.org/cache/epub/1514/pg1514.txt";
IntDict concordance;
GetData data;
Frecuency conteo;
// We will use spaces and punctuation as delimiters


void setup() {
  size(360, 640);
  data = new GetData(url);
  conteo = new Frecuency();
}

void draw() {
  background(255);

  concordance = data.text();
  conteo.count(concordance);

}
