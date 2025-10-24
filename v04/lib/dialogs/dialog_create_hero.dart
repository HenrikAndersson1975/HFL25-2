import 'dialogs_helper.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/services/singletons_service.dart';
import 'package:v04/interfaces/hero_data_managing.dart';


Future<void> dialogCreateHero() async {
  HeroModel? hero = _createHero();   
    
  if (hero != null) {

    clearScreen();
    print('--- Ny hjälte har skapats ---');
    print(hero.toDisplayString());
    print('');

    try {
      // Försök att lägga till hjälten till listan
      HeroDataManaging manager = getHeroDataManager();
      await manager.addHero(hero);
    }
    catch (e) {
      print(e);
    }
    
    print('');
    waitForEnter('Tryck ENTER för att fortsätta');
  }
}



/// Användaren fyller i egenskaper för en hjälte som sedan skapas och returneras.
HeroModel? _createHero() {

  clearScreen();

  print('--- Skapa hjälte ---');
  print('Ange egenskaper för hjälten.');
  String name = getStringFromUser('Namn', minLength: 2);
  int strength = getIntegerFromUser('Styrka', 0, 100);
  String gender = getStringFromUser('Kön', validValues:["kvinna","man","annat"]);
  String alignment = getStringFromUser('Moralisk inriktning', validValues:["god","ond","neutral"]);

// måste översätta alignment till engelska...

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




