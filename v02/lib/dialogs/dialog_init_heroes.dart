
import '../extensions.dart';
import '../hero.dart';
import '../file.dart' as file;
import '../predefined_heroes.dart';
import 'dialog_menu.dart';
import 'dialog_file_path.dart';
import 'dialogs_helper.dart';


/// Alternativ för hur man vill initiera hjältelistan
enum InitHeroesAction {
  loadFromFile, usePredefinedHeroes, createRandomizedHeroes, noHeroes
}


/// Presenterar olika alternativ för användaren för att initiera hjältelistan
List<Map<String, dynamic>> dialogInitHeroes(String? filePath) {

  List<Map<String, dynamic>> heroes = [];

  // Om en fil har angivits försök att ladda hjältar från filen
  if (filePath != null) {
    var (success, loadedHeroes) = _tryLoadHeroes(filePath);
    if (success && loadedHeroes.isNotEmpty) {
      heroes = loadedHeroes;  
    }
  }

  // Om inga hjältar har laddats, visa en meny för användaren
  if (heroes.isEmpty) {
    InitHeroesAction menuChoice;
    {
      List<MenuOption<InitHeroesAction>> menuOptions = [
        MenuOption(InitHeroesAction.loadFromFile, 'Ladda hjältar från en fil'),
        MenuOption(InitHeroesAction.usePredefinedHeroes, 'Ladda fördefinierade hjältar'),
        MenuOption(InitHeroesAction.createRandomizedHeroes, 'Skapa hjältar med slumpmässigt skapade egenskaper'),
        MenuOption(InitHeroesAction.noHeroes, 'Starta utan hjältar')   
      ];
      menuChoice = dialogMenu<InitHeroesAction>('--- Initiera listan med hjältar ---', menuOptions, 'Välj ett alternativ: ');
    }

    // Hantera användarens val i menyn
    switch (menuChoice) {
      case InitHeroesAction.loadFromFile:
        heroes = _loadHeroes();
        break;
      case InitHeroesAction.usePredefinedHeroes:
        heroes = getPredefinedHeroes();   
        break;
      case InitHeroesAction.createRandomizedHeroes:   
        heroes = _getRandomHeroes();    
        break;
      case InitHeroesAction.noHeroes:
        heroes = [];
        break;
    }
  }

  return heroes;
}





/// Användaren ges möjlighet att ladda hjältar från en fil
List<Map<String, dynamic>> _loadHeroes() {

  List<Map<String, dynamic>> loadedHeroes = [];

  bool tryLoad = true;

  while (tryLoad) {
    
    // frågar användaren efter en fil att ladda hjältarna från
    String? loadPath = dialogFilePath("--- Ladda hjältar från fil ---", null);

    // försöker att ladda hjältarna från fil  
    var (success, loadedHeroes) = _tryLoadHeroes(loadPath);

    // om det gick bra, försök inte att ladda igen
    if (success && loadedHeroes.isNotEmpty) {
      tryLoad = false;  
    }

    // om det inte gick bra, ge användaren möjlighet att ange annan fil att ladda från
    else {    
      // 
      if (loadPath != null) {
        print('\nDet gick inte att läsa från $loadPath.');
      }

      // fråga om man vill försöka igen
      tryLoad = acceptOrDecline("\nVill du försöka med en annan källfil? (j/n) ", "j", "n");
    }
  }

  return loadedHeroes;
}


/// Laddar hjältar från fil om en fil är definierad
(bool, List<Map<String, dynamic>>) _tryLoadHeroes(String? loadPath) {

  bool success = false;

  List<Map<String, dynamic>> heroes = [];

  // om path finns definierad, försök läsa in hjältar från fil
  if (loadPath != null) {
    try {
      print('\nLäser in hjältar från fil...');
      heroes = file.readHeroesFromFile(loadPath);
      success = true;
    }
    catch (e) {
      print('Fel vid inläsning från fil: $e');      
    }
  } 
  
  return (success, heroes);
}



List<Map<String, dynamic>> _getRandomHeroes() {

  List<Map<String, dynamic>> heroes = [];

  clearScreen();
  print('--- Skapa hjältar automatiskt ---');

  int numberOfHeroesToCreate = getIntegerFromUser("\nHur många hjältar vill du skapa? ", 0, 100);
  for (int i=0; i<numberOfHeroesToCreate; i++) {
    Map<String, dynamic>? newHero;
    try {
      newHero = createRandomHero();         
    }
    catch (e) {
      print('Det gick inte att skapa hjälte nummer ${i+1}. Fel:$e');
    }
    if (newHero!=null) { heroes.addHeroToList(newHero); }
  }

  return heroes;
}