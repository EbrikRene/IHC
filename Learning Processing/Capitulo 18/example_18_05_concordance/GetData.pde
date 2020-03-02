class GetData {
  
  String delimiters = " ,.?!;:[]";
  String url;
  IntDict concordance;

    GetData(String urltemp) {
      url = urltemp;
      
    }
  
  IntDict text() {
    // Load A Midsummer Night's Dream into an array of strings
  
  String[] rawtext = loadStrings(url);

  // Join the big array together as one long string
  String everything = join(rawtext, "" );

  // All the lines in King Lear are first joined as one big String and then split up into an array of individual words. 
  // Note the use of splitTokens() since we are using spaces and punctuation marks all as delimiters.  
  allwords = splitTokens(everything, delimiters);

  // Make a new empty dictionary
  concordance = new IntDict();

  for (int i = 0; i < allwords.length; i++) {
    String s = allwords[i].toLowerCase();
    concordance.increment(s);
  }

  // Sort so that words that appear most often are first
  concordance.sortValues();
  return concordance;
}
}
