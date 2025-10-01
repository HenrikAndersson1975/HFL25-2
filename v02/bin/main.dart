import 'package:v02/dialogs/dialogs.dart'; 
import 'package:v02/enumerations.dart';
import 'package:v02/heroes_file_handler.dart' as heroes_file_handler;
import 'package:v02/predefined_heroes.dart';

void main(List<String> arguments) {
  
  String? heroesFilePath;  // om ingen fil är definierad, startas programmet med fördefinierade hjältar och de sparas inte vid avslut


  clearScreen();

  // ladda hjältar från fil eller starta med fördefinierade hjältar
  List<Map<String, dynamic>> heroes = loadHeroes(heroesFilePath);

  // skriv ut antal hjältar som har laddats
  print('\nProgrammet startar med ${heroes.length} ${heroes.length == 1 ? 'hjälte' : 'hjältar'}.');


  // menyrubrik
  String menuHeader = '=== MENY ===';

  // menyalternativ
  List<MenuOption> menuOptions = [
    MenuOption(Action.addHero, 'Lägg till hjälte'),
    MenuOption(Action.listHeroes, 'Visa hjältar'),
    MenuOption(Action.searchHero, 'Sök hjälte'),
    MenuOption(Action.exit, 'Avsluta')
  ];

  // uppmaning till användaren
  String menuPrompt = 'Välj ett alternativ: ';



  bool isRunning = true;  // sätts till false för att avsluta programmet

  while (isRunning) {
    
    // användaren gör ett val från menyn
    Action action = dialogMenu(menuHeader, menuOptions, menuPrompt);

    // hantera valt alternativ
    switch (action) {
      case Action.addHero:
        print('Lägger till hjälte...');
        dialogAddHero(heroes);
        print('Hjälte tillagd.');
        int xxx = heroes.length;
        print('Antal hjältar: $xxx');
        break;

      case Action.listHeroes:
        dialogListHeroes(heroes);
        break;

      case Action.searchHero:
        dialogSearchHero(heroes);
        break;

      case Action.exit:
        saveHeroes(heroes, heroesFilePath);
        print('\nProgrammet avslutat.');
        isRunning = false;
        break;
    }
  }
}

/// Sparar hjältar till fil om en fil är definierad
void saveHeroes(List<Map<String, dynamic>> heroes, String? savePath) {  
  if (savePath != null) {
    try {
      print('Sparar hjältar till fil...');
      heroes_file_handler.writeHeroesToFile(savePath, heroes);
    }
    catch (e) {
      print('Fel vid skrivning till fil: $e');
    }
  }  
}


/// Laddar hjältar från fil om en fil är definierad, annars startar med fördefinierade hjältar
List<Map<String, dynamic>> loadHeroes(String? loadPath) {

  List<Map<String, dynamic>> heroes = [];

  // om path finns definierad, försök läsa in hjältar från fil
  if (loadPath != null) {
    try {
      print('Läser in hjältar från fil...');
      heroes = heroes_file_handler.readHeroesFromFile(loadPath);
    }
    catch (e) {
      print('Fel vid inläsning från fil: $e');
      print('Startar med tom hjälte-lista.');
    }
  } 
  
  // om ingen fil är definierad, starta med fördefinierade hjältar
  else {
    heroes = getPredefinedHeroes();   
  }

  return heroes;
}