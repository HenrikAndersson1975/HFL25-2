import 'package:v02/dialogs/dialogs.dart'; 
import 'package:v02/file.dart' as file;
import 'package:v02/extensions.dart';
import 'dart:convert';

void main(List<String> arguments) {
  
  clearScreen();  

  // Letar efter sökväg till fil bland argument.
  String? heroesFilePath = _getFilePathFromArguments(arguments);  

  // Initiera hjältelista enligt användarens val
  List<Map<String, dynamic>> heroes = _initHeroes(heroesFilePath);
 
  bool isRunning = true;  // sätts till false för att avsluta programmet

  while (isRunning) {
    
    // Användaren gör ett val från menyn   
    MainMenuAction menuChoice = dialogMenu<MainMenuAction>
    (
      '=== MENY ===', 
      [
        MenuOption(MainMenuAction.addHero, 'Lägg till hjälte'),
        MenuOption(MainMenuAction.listHeroes, 'Visa hjältar'),
        MenuOption(MainMenuAction.searchHero, 'Sök hjälte'),
        MenuOption(MainMenuAction.exit, 'Avsluta')
      ], 
      'Välj ett alternativ: '
    );

    // Hantera valt alternativ
    switch (menuChoice) {
      case MainMenuAction.addHero:
       
        Map<String, dynamic>? newHero = dialogCreateHero();
        
        if (newHero != null) {
          heroes.addHeroToList(newHero);

          clearScreen();
          print('--- Ny hjäte har skapats ---');
          newHero.printHero();
          print('');
          _waitForEnterToContinue();
        }
        break;

      case MainMenuAction.listHeroes:
        dialogListHeroes(heroes);
        break;

      case MainMenuAction.searchHero:
        dialogSearchHero(heroes);
        break;

      case MainMenuAction.exit:    
        bool exit = dialogExit();

        if (exit && heroes.isNotEmpty && (heroesFilePath == null || _hasPendingChanges(heroes, heroesFilePath))) {
          // fråga om användaren vill spara hjältarna till fil innan programmet avslutas                    
          bool trySave = acceptOrDecline("\nInnan du avslutar, vill du spara hjältarna till en fil? (j/n) ", "j", "n");
          if (trySave) {
            dialogSaveHeroes(heroes, heroesFilePath);
          }
        }

        isRunning = !exit;

        break;
    }
  }

  clearScreen();
  print('Programmet har avslutats.');
}


/// Alternativ i programmets huvudmeny
enum MainMenuAction {
  addHero, listHeroes, searchHero, exit
}


List<Map<String, dynamic>> _initHeroes(String? heroesFilePath) {
  
  List<Map<String, dynamic>> heroes = [];
  
  
  // Om filnamn har angivits försök att ladda hjältar från filen
  if (heroesFilePath != null) {
    var (success, loadedHeroes) = tryLoadHeroes(heroesFilePath);
    if (success) {
      heroes =loadedHeroes;
    }
  }

  // Om det inte finns några hjältar i listan, fråga användraren hur den vill initiera listan.
  if (heroes.isEmpty) {   
    heroes = dialogInitHeroes();
  }

  
  // Skriv ut antal hjältar som har laddats
  clearScreen();
  print('--- Hjältelista initierad ---');
  print('Programmet startar med ${heroes.length} ${heroes.length == 1 ? 'hjälte' : 'hjältar'}.');
  print('');
  _waitForEnterToContinue();


  return heroes;
}



/// Tar första startargument och undersöker om det finns en fil med det namnet
String? _getFilePathFromArguments(List<String> arguments) {
  String? filePath;
  if (arguments.isNotEmpty) {  
    String suggestedFilePath = arguments[0];
    try {
      bool exists = file.isExistingFilePath(suggestedFilePath);
      if (exists) {
        print("Filen $suggestedFilePath hittades.");
        filePath = suggestedFilePath;       
      }
      else {
        print("Filen $suggestedFilePath hittades inte.");
        _waitForEnterToContinue();
      }
    }
    catch (e) {
        print('Det uppstod fel när programmet skulle hitta fil $suggestedFilePath: $e');
        _waitForEnterToContinue();
    }

    
  }
  return filePath;
}


void _waitForEnterToContinue() {
  waitForEnter('Tryck ENTER för att fortsätta');
}




/// Undersöker om det har gjorts några ändringar i hjältelista, jämfört med eventuellt inläst fil
bool _hasPendingChanges(List<Map<String, dynamic>> heroes, String filePath) {

  bool isChanged = true; // kommer att sättas till false om innehållet i heroes är identiskt med innehållet i fil som laddades vid programstart.

  
  // Undersöker om det gjorts någon förändring jämfört med den fil
  List<Map<String, dynamic>> heroesInLoadedFile;
  {
    try {
      heroesInLoadedFile = file.readHeroesFromFile(filePath);
    }
    catch (e) {
      heroesInLoadedFile = [];
    }
  }

  // Om det är lika många element i båda listorna måste element jämföras med varandra
  if (heroes.length == heroesInLoadedFile.length)
  {
    // Sortera listorna på id
    heroes.orderHeroesById();
    heroesInLoadedFile.orderHeroesById();

    isChanged = false; // ändras till true om skillnad hittas

    // Eftersom elementen är sorterade på id, måste hjälte ha samma position i båda listorna om ingen förändring har skett
    for(int i=0; i < heroes.length && !isChanged; i++) {
            
      if (heroes[i].length == heroesInLoadedFile[i].length) {
      
        // Slapp kontroll...
        // Jämför json-strängar, kan ev ge falskt 'false' om egenskaper inte kommer i samma ordning
        String jsonThisHero = json.encode(heroes[i].length);
        String jsonOtherHero = json.encode(heroesInLoadedFile[i]);  
        isChanged = jsonThisHero != jsonOtherHero;
      }
      else {
        isChanged = true;
      }
    }
       
  }

  return isChanged;
}