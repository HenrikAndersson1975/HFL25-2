// Lexikon med svenska till engelska översättningar
  Map<String, String> _dictionary = {
    'kvinna': 'Female',
    'man': 'Male',
    'annat': 'Other',

    'god': 'good',
    'ond': 'bad',
    'neutral': 'neutral',

    'namn': 'name',
    'styrka': 'strength'
  };

  String translateToEnglish(String swedishWord) {
    return _dictionary[swedishWord] ?? swedishWord;
  }
  String translateToSwedish(String englishWord) {
    Map<String, String> reversedDictionary = _dictionary.map((key, value) => MapEntry(value, key));
    return reversedDictionary[englishWord] ?? englishWord;
  }

  List<String> translateListToEnglish(List<String> swedishWords) {
    List<String> translation = [];
    for(int i=0; i<swedishWords.length; i++) {
      String swedishWord = swedishWords[i];
      translation.add(_dictionary[swedishWord] ?? swedishWord);
    }
    return translation;
  }
  List<String> translateListToSwedish(List<String> englishWords) {
    Map<String, String> reversedDictionary = _dictionary.map((key, value) => MapEntry(value, key));  
    List<String> translation = [];
    for(int i=0; i<englishWords.length; i++) {
      String englishWord = englishWords[i];
      translation.add(reversedDictionary[englishWord] ?? englishWord);
    }
    return translation;
  }

  