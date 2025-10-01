import 'package:v02/dialogs/dialogs.dart'; 
import 'package:v02/enumerations.dart';
import 'package:v02/hero_creator.dart';
import 'package:v02/heroes_file_handler.dart' as heroes_file_handler;
import 'package:v02/heroes_list_functions.dart';
import 'package:v02/predefined_heroes.dart';

void main(List<String> arguments) {
  

  clearScreen();  

  // letar efter sökväg till fil bland argument.
  String? heroesFilePath = getFilePathFromArguments(arguments);  


  // ladda hjältar från fil eller starta med fördefinierade hjältar
  List<Map<String, dynamic>> heroes = initHeroes(heroesFilePath);



  
  

  // skriv ut antal hjältar som har laddats
  print('\nProgrammet startar med ${heroes.length} ${heroes.length == 1 ? 'hjälte' : 'hjältar'}.');
  waitForEnter("\nTryck på Enter för att komma till menyn.");

  // menyrubrik
  String menuHeader = '=== MENY ===';

  // menyalternativ
  List<MenuOption<MainMenuAction>> menuOptions = [
    MenuOption(MainMenuAction.addHero, 'Lägg till hjälte'),
    MenuOption(MainMenuAction.listHeroes, 'Visa hjältar'),
    MenuOption(MainMenuAction.searchHero, 'Sök hjälte'),
    MenuOption(MainMenuAction.exit, 'Avsluta')   
  ];

  // uppmaning till användaren
  String menuPrompt = 'Välj ett alternativ: ';



  bool isRunning = true;  // sätts till false för att avsluta programmet

  while (isRunning) {
    
    // användaren gör ett val från menyn
    MainMenuAction action = dialogMenu<MainMenuAction>(menuHeader, menuOptions, menuPrompt);

    // hantera valt alternativ
    switch (action) {
      case MainMenuAction.addHero:

        // TODO

        
        dialogAddHero(heroes);
        
        break;

      case MainMenuAction.listHeroes:
        dialogListHeroes(heroes);
        break;

      case MainMenuAction.searchHero:
        dialogSearchHero(heroes);
        break;

      case MainMenuAction.exit:    

        // fråga om användaren vill spara hjältarna till fil
        saveHeroes(heroes, heroesFilePath);
     
        // fråga användaren om den vill avsluta
        isRunning = !acceptOrDecline("\nÄr du säker på att du vill avsluta programmet? (j/n) ", "j", "n");
        
        break;
    }
  }
}


List<Map<String, dynamic>> initHeroes(String? filePath) {

  List<Map<String, dynamic>> heroes = [];

  // Om en fil har angivits försök att ladda hjältar från filen
  if (filePath != null) {
    var (success, loadedHeroes) = tryLoadHeroes(filePath);
    if (success && loadedHeroes.isNotEmpty) {
      heroes = loadedHeroes;  
    }
  }

  // Om inga hjältar har laddats, visa en meny för användaren
  if (heroes.isEmpty) {
    InitHeroesAction action;
    {
      List<MenuOption<InitHeroesAction>> menuOptions = [
        MenuOption(InitHeroesAction.loadFromFile, 'Ladda hjältar från en fil'),
        MenuOption(InitHeroesAction.usePredefinedHeroes, 'Ladda fördefinierade hjältar'),
        MenuOption(InitHeroesAction.createRandomizedHeroes, 'Skapa hjältar med slumpmässigt skapade egenskaper'),
        MenuOption(InitHeroesAction.noHeroes, 'Starta utan hjältar')   
      ];
      action = dialogMenu<InitHeroesAction>('Hur vill du initiera listan med hjältar?', menuOptions, 'Välj ett alternativ: ');
    }

    switch (action) {
      case InitHeroesAction.loadFromFile:
        heroes = loadHeroes();
        break;
      case InitHeroesAction.usePredefinedHeroes:
        heroes = getPredefinedHeroes();   
        break;
      case InitHeroesAction.createRandomizedHeroes:   
        int numberOfHeroesToCreate = getIntegerFromUser("\nHur många hjältar vill du skapa? ", 0, 30);
        for (int i=0; i<numberOfHeroesToCreate; i++) {
          Map<String, dynamic> newHero = createRandomHero();
          addHeroToList(newHero, heroes);
        }
        break;
      case InitHeroesAction.noHeroes:
        heroes = [];
        break;
    }
  }

  return heroes;
}


List<Map<String, dynamic>> loadHeroes() {

  List<Map<String, dynamic>> loadedHeroes = [];

  bool tryLoad = true;

  while (tryLoad) {
    
    // frågar användaren efter en fil att ladda hjältarna från
    String? loadPath = dialogFilePath(null);

    // försöker att ladda hjältarna från fil  
    var (success, loadedHeroes) = tryLoadHeroes(loadPath);

    // om det gick bra, försök inte att ladda igen
    if (success && loadedHeroes.isNotEmpty) {
      tryLoad = false;  
    }

    // om det inte gick bra, ge användaren möjlighet att ange annan fil att ladda från
    else {    
      // 
      if (loadPath != null) {
        print('Det gick inte att läsa från $loadPath.');
      }

      // fråga om man vill försöka igen
      tryLoad = acceptOrDecline("Vill du försöka med en annan källfil? (j/n) ", "j", "n");
    }

  }

  return loadedHeroes;
}


void saveHeroes(List<Map<String, dynamic>> heroes, String? filePath) {
    // fråga om användaren vill spara hjältarna till fil             
    bool trySave = acceptOrDecline("\nVill du spara hjältarna till en fil? (j/n) ", "j", "n");

    // om användaren vill spara till fil
    while (trySave) {
      
      // frågar användaren efter en fil att spara hjältarna till, skickar med ett förslag 
      String? savePath = dialogFilePath(filePath);

      // försöker att spara hjältarna till fil
      bool trySaveSuccess = trySaveHeroes(heroes, savePath);

      // om det gick bra, försök inte att spara igen
      if (trySaveSuccess) {
        trySave = false;  
      }

      // om det inte gick bra, ge användaren möjlighet att ange annan fil att spara till
      else {    
        // 
        if (savePath != null) {
          print('Det gick inte att spara till $savePath.');
        }

        // Fråga om man vill försöka igen
        trySave = acceptOrDecline("Vill du försöka med en annan målfil? (j/n) ", "j", "n");
      }

    }
}

/// Tar första startargument och undersöker om det finns en fil men det namnet
String? getFilePathFromArguments(List<String> arguments) {
  String? filePath;
  if (arguments.isNotEmpty) {  
    String suggestedFilePath = arguments[0];
    try {
      bool exists = heroes_file_handler.isExistingFilePath(suggestedFilePath);
      if (exists) {
        print("Filen $suggestedFilePath hittades.");
        filePath = suggestedFilePath;
      }
      else {
        print("Filen $suggestedFilePath hittades inte.");
      }
    }
    catch (e) {
        print('Det uppstod fel när programmet skulle hitta fil $suggestedFilePath: $e');
    }
  }
  return filePath;
}


/// Sparar hjältar till fil 
bool trySaveHeroes(List<Map<String, dynamic>> heroes, String? savePath) {  

  bool success = false;
  
  if (savePath != null) {
    try {
      print('Sparar hjältar till fil...');
      success = heroes_file_handler.writeHeroesToFile(savePath, heroes);
    }
    catch (e) {
      print('Fel vid skrivning till fil: $e');
      success = false;
    }
  }  
  else {
    print('Ingen fil har angivits.');
  }

  return success;
}



/// Laddar hjältar från fil om en fil är definierad
(bool, List<Map<String, dynamic>>) tryLoadHeroes(String? loadPath) {

  bool success = false;

  List<Map<String, dynamic>> heroes = [];

  // om path finns definierad, försök läsa in hjältar från fil
  if (loadPath != null) {
    try {
      print('Läser in hjältar från fil...');
      heroes = heroes_file_handler.readHeroesFromFile(loadPath);
      success = true;
    }
    catch (e) {
      print('Fel vid inläsning från fil: $e');      
    }
  } 
  
  return (success, heroes);
}