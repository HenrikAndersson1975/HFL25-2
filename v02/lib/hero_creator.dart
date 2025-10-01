import 'dart:math';  // ev ta bort sedan, används för random

Map<String, dynamic> createHero(String name, int strength, String gender, String alignment) {

  Map<String, dynamic> hero = {

    "id": "-1",  // id sätts när hjälten läggs till i listan

    "name": name,
    "powerstats": {
      "strength": strength.toString()
    },
    "appearance": {
      "gender": gender,
      "race": "Människa",
    },
    "biography": {
      "alignment": alignment,
    }
  };

  return hero;
}


Map<String, dynamic> createRandomHero() {
  var random = Random();
  
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
    int min = 0;
    int max = 100;
    randomStrength = min + random.nextInt(max - min + 1);
  }
  String randomGender;
  {
    List<String> genders = ["Man", "Kvinna", "Annat"];
    randomGender = genders[random.nextInt(genders.length)];
  }
  String randomAlignment;
  {
    List<String> alignments = ["god", "ond", "neutral"];
    randomAlignment = alignments[random.nextInt(alignments.length)];
  }
  
  
  // skapa en ny hjälte
  Map<String, dynamic> newHero = createHero(randomName, randomStrength, randomGender, randomAlignment);

    
  return newHero;
}