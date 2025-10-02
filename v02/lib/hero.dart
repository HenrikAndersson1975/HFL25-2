import 'dart:math';


Map<String, dynamic> createHero(String name, int strength, String gender, String alignment) {

  Map<String, dynamic> hero = {

    "id": "-1",  // id sätts när hjälten läggs till i listan

    "name": name,
    "powerstats": {
      "strength": strength.toString()
    },
    "appearance": {
      "gender": gender,
      "race": "människa",
    },
    "biography": {
      "alignment": alignment,
    }
  };

  return hero;
}


/// Map med giltiga värden för egenskaper hos hjälte
Map<String, dynamic> getValidProperties() {

  Map<String, dynamic> validProperties = {

    "powerstats": {
      "strength": { "min": 0, "max": 100 }
    },
    "apperance": {
      "gender": ["man", "kvinna", "annat"]
    },
    "biography": {
      "alignment": ["god", "ond", "neutral"]
    }
  };

  return validProperties;
}


/// Hämtar värde för angiven key. 
/// Om key finns flera gånger, returneras första. 
dynamic getPropertyValue(Map<String, dynamic> map, String key) {
  // Kollar om nyckeln finns på högsta nivå
  if (map.containsKey(key)) {
    return map[key];
  }
  
  // Kollar genom nästlade maps 
  for (var nestedMap in map.values) {
    if (nestedMap is Map<String, dynamic>) {
      // rekursiv sökning i nästlad map
      var result = getPropertyValue(nestedMap, key);
      if (result != null) {
        return result;
      }
    }
  }

  // Om nyckeln inte hittas, returnera null
  return null;
}





Map<String, dynamic> createRandomHero() {
  var random = Random();
  

  Map<String, dynamic> validProperties = getValidProperties();

  String randomName;
  {      
    const chars = 'abcdefghijklmnopqrstuvwxyzåäö';   
    int minCharsInName = 3; int maxCharsInName = 7;
    int nameLength = random.nextInt(maxCharsInName - minCharsInName + 1) + minCharsInName; 
    randomName = List.generate(nameLength, (index) => chars[random.nextInt(chars.length)]).join();
    randomName = randomName[0].toUpperCase() + randomName.substring(1);
  }
  int randomStrength;
  {
    dynamic interval = getPropertyValue(validProperties, "strength");
    dynamic min = getPropertyValue(interval, "min");
    dynamic max = getPropertyValue(interval, "max"); 
    randomStrength = min + random.nextInt(max - min + 1);
  }
  String randomGender;
  {
    List<String> genders = getPropertyValue(validProperties, "gender"); 
    randomGender = genders[random.nextInt(genders.length)];
  }
  String randomAlignment;
  {
    List<String> alignments = getPropertyValue(validProperties, "alignment");
    randomAlignment = alignments[random.nextInt(alignments.length)];
  }
  
  
  // skapa en ny hjälte
  Map<String, dynamic> newHero = createHero(randomName, randomStrength, randomGender, randomAlignment);

    
  return newHero;
}