
import 'dialogs_helper.dart';
import 'package:v04/models/exports_hero_models.dart';

/// Användaren fyller i egenskaper för en hjälte som sedan skapas och returneras.
HeroModel? dialogCreateHero() {

  clearScreen();

  print('--- Skapa hjälte ---');
  print('Ange egenskaper för hjälten.');
  String name = getStringFromUser('Namn', minLength: 2);
  String gender = getStringFromUser('Kön', validValues:["kvinna","man","annat"]);
  int strength = getIntegerFromUser('Styrka', 0, 100);
  String alignment = getStringFromUser('Moralisk inriktning', validValues:["god","ond","neutral"]);

  gender = _translate(gender, {
    'kvinna': 'Female',
    'man': 'Male',
    'annat': 'Other'
  });

  alignment = _translate(alignment, {
    'god': 'good',
    'ond': 'bad',
    'neutral': 'neutral'
  });

  Appearance? appearance = Appearance(gender: gender, race: null, height: null, weight: null, eyeColor: null, hairColor: null);  
  Powerstats? powerstats = Powerstats(intelligence: null, strength: strength, speed: null, durability: null, power:null, combat: null);
  Biography? biography = Biography(fullName: null, alterEgos: null, aliases: null, placeOfBirth: null, firstAppearance: null, publisher: null, alignment: alignment);
  Connections? connections;
  Work? work;
  Image? image;

  HeroModel newHero = HeroModel(
    response: "success", 
    id: null, 
    name: name, 
    powerstats: powerstats, 
    biography: biography, 
    appearance: appearance,
    work: work, 
    connections: connections, 
    image: image);
  
  return newHero;
}

String _translate(String word, Map<String,String> dictionary) {
  if (dictionary.containsKey(word)) {
    return dictionary[word]!;
  } else {
    return word;
  }
}