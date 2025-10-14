import 'package:v03/dialogs/exports_dialogs.dart'; 
import 'package:v03/interfaces/hero_data_managing.dart';
import 'package:v03/managers/hero_data_manager.dart';
import 'package:v03/interfaces/hero_storage_managing.dart';
import 'package:v03/managers/hero_file_manager.dart';
//import 'package:v03/managers/hero_database_manager.dart';
import '../test/mocks/mock_hero_data_manager.dart';
import 'package:get_it/get_it.dart';

void main(List<String> arguments) async {
  
  clearScreen();  

  // analysera startargument
  var (storageType, filePath) = _handleArguments(arguments);
  // -t 
  // -f   
  // -f filnamn 
  // -d    (objectbox) - inte implementerat

  _registerManagers(storageType, filePath);

  // visa startmeddelande om hjältar ska laddas
  if (storageType != StorageType.none)
  {
    // Visa startmeddelande
    await dialogInit();
  }

  // Gå till menyloopen
  await _runMainMenu();

  clearScreen();
  print('Programmet har avslutats.');
}


/// Alternativ i programmets huvudmeny
enum MainMenuAction {
  addHero, listHeroes, searchHero, exit
}

/// Menyloopen
Future<void> _runMainMenu() async {
  bool isRunning = true;

  while (isRunning) {
    MainMenuAction menuChoice = dialogMenu<MainMenuAction>(
      '=== MENY ===',
      [
        MenuOption(MainMenuAction.addHero, 'Lägg till hjälte'),
        MenuOption(MainMenuAction.listHeroes, 'Visa hjältar'),
        MenuOption(MainMenuAction.searchHero, 'Sök hjälte'),
        MenuOption(MainMenuAction.exit, 'Avsluta'),
      ],
      'Välj ett alternativ: ',
    );

    switch (menuChoice) {
      case MainMenuAction.addHero:
        await dialogCreateHero();
        break;

      case MainMenuAction.listHeroes:
        await dialogListHeroes();
        break;

      case MainMenuAction.searchHero:
        await dialogSearchHero();
        break;

      case MainMenuAction.exit:
        bool exit = dialogExit();
        isRunning = !exit;
        break;
    }
  }
}

enum StorageType {
  test, file, database, none
}



void _registerManagers(StorageType storageType, String? filePath) {

  final getIt = GetIt.instance;

    switch (storageType) {

      // om man vill starta i testläge
      case StorageType.test:   
        print('Programmet startar i testläge. En testlista med hjältar kommer att laddas.'); 
        waitForEnter('Tryck ENTER för att starta.');     
        getIt.registerSingleton<HeroDataManaging>(MockHeroDataManager());        
        break;
      
      // om man vill använda fil för att läsa och skriva hjältar till
      case StorageType.file:
        filePath = dialogFilePath('Du har angivit att du vill att programmet ska använda en fil för att läsa från och skriva till.', suggestedFile: filePath);   
        HeroStorageManaging storage = HeroFileManager(filePath ?? 'heroes.json');    
        getIt.registerSingleton<HeroDataManaging>(HeroDataManager(storage: storage));  
        break;

      // om man vill använda databas
      case StorageType.database:      
        //HeroStorageManaging storage = HeroDatabaseManager();
        //getIt.registerSingleton<HeroDataManaging>(HeroDataManager(storage: storage));  
        throw Exception('Du vill använda en databas. Vi lugnar oss lite med det... Det är inte implementerat.'); 
        
      default:  
        print('Du har valt att köra programmet utan lagring. Inga hjältar finns när programmet startar och inga hjältar kommer att sparas till annan körning.');
        waitForEnter('Tryck ENTER för att starta.');
        getIt.registerSingleton<HeroDataManaging>(HeroDataManager(storage: null)); 
        break;     
    }
  
}


(StorageType,String?) _handleArguments(List<String> arguments) {
  
  StorageType type = StorageType.none;
  String? filePath;

  if (arguments.isNotEmpty) {   
    
    String flag = arguments[0]; // första argumentet ska vara -t, -f eller -d

    if (flag == '-t') {
      type = StorageType.test;
    } 
    else if (flag == '-f') {  
      type = StorageType.file;
      if (arguments.length > 1) {  // andra argumentet ska vara ett filnamn
        filePath = arguments[1];
      }
    } 
    else if (flag == "-d") {
      type = StorageType.database;
    }
    else {
      print('Okänt argument: $flag');
    }
  }

  return (type, filePath);
}