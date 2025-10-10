import 'package:v03/managers/exports_data_managing.dart';
import 'dialogs_helper.dart';
import 'package:v03/models/exports_hero_models.dart';


Future<void> dialogCreateHero() async {
  HeroModel? newHero = _createHero();        
  if (newHero != null) {
    await _saveHero(newHero);
  }
}


/// Sparar hjälten och skriver ut hjälten
Future<void> _saveHero(HeroModel hero) async {
  HeroDataManaging manager = HeroDataManager();  

  try {
    await manager.saveHero(hero);
    
    clearScreen();
    print('--- Ny hjälte har skapats ---');
    print(hero.toDisplayString());
    print('');
    waitForEnter('Tryck ENTER för att fortsätta');
  }
  catch (e) {
    print('Det uppstod problem när hjälte skulle sparas: $e');
  }
}



/// Användaren fyller i egenskaper för en hjälte som sedan skapas och returneras.
HeroModel? _createHero() {

  clearScreen();

  print('--- Skapa hjälte ---');
  print('Ange egenskaper för hjälten.');
  String name = getStringFromUser('Namn', null);
  int strength = getIntegerFromUser('Styrka', 0, 100);
  String gender = getStringFromUser('Kön', ["kvinna","man","annat"]);
  String alignment = getStringFromUser('Moralisk inriktning', ["god","ond","neutral"]);

// TODOOOOO
  

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




