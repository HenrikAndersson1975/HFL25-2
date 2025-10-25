

import 'package:v04/dialogs/exports_dialogs.dart'; 
import 'package:v04/dialogs/exports_menu_options.dart';
import 'package:v04/managers/hero_data_manager.dart';
import 'package:v04/managers/hero_file_manager.dart';
import 'package:v04/services/singletons_service.dart';

import '../test/mocks/mock_hero_data_manager.dart';

import 'package:v04/managers/hero_network_manager.dart';

import 'package:v04/interfaces/hero_storage_managing.dart';


void main(List<String> arguments) async {
  

  clearScreen();  

  // analysera startargument
  var (storageType, filePath) = _analyseArguments(arguments);
  // -t 
  // -f   
  // -f filnamn 

  _registerManagers(storageType, filePath);

  // visa startmeddelande om hjältar ska laddas
  if (storageType != StorageType.none)
  {
    await dialogInit();
  }

  // Gå till menyloopen
  await _runMainMenu();

  clearScreen();
  print('Programmet har avslutats.');
}


/// Alternativ i programmets huvudmeny
enum _MainMenuAction {
  addHero, listHeroes, searchHero, exit, searchHeroOnline
}

/// Menyloopen
Future<void> _runMainMenu() async {
  bool isRunning = true;

  while (isRunning) {
    
    clearScreen();

    _MainMenuAction menuChoice = dialogMenu<_MainMenuAction>(
      '=== MENY ===',
      [
        MenuOption(_MainMenuAction.searchHeroOnline, 'Sök hjälte online'),
        MenuOption(_MainMenuAction.addHero, 'Skapa hjälte'),
        MenuOption(_MainMenuAction.listHeroes, 'Hantera hjältar (visa/ny/radera)'),
        MenuOption(_MainMenuAction.searchHero, 'Sök hjälte'),
        MenuOption(_MainMenuAction.exit, 'Avsluta program'),
      ],
      'Välj ett alternativ: ',
    );

    switch (menuChoice) {

      case _MainMenuAction.searchHeroOnline: 
        await menuOptionSearchHeroOnline();
        break;

      case _MainMenuAction.addHero:
        await menuOptionCreateHero();
        break;

      case _MainMenuAction.listHeroes:
        await menuOptionListHeroes();
        break;

      case _MainMenuAction.searchHero:
        await menuOptionSearchHero();
        break;

      case _MainMenuAction.exit:
        bool exit = menuOptionExit();
        isRunning = !exit;
        break;
    }
  }
}

enum StorageType {
  test, file, none
}





void _registerManagers(StorageType storageType, String? filePath) {


    switch (storageType) {

      // om man vill starta i testläge
      case StorageType.test:   
        print('Programmet startar i testläge. En testlista med hjältar kommer att laddas.');
        print(''); 
        waitForEnter('Tryck ENTER för att starta.');     
        registerHeroDataManager(MockHeroDataManager());   
        break;
      
      // om man vill använda fil för att läsa och skriva hjältar till
      case StorageType.file:
        filePath = dialogFilePath('Du har angivit att du vill att programmet ska använda en fil för att läsa från och skriva till.', suggestedFile: filePath);  

        filePath ??= 'heroes.json';

        HeroStorageManaging storage = HeroFileManager(filePath);
        registerHeroDataManager(HeroDataManager(storage: storage));  
        break;
   
      default:  
        print('Du har valt att köra programmet utan lagring.');
        print('Inga hjältar finns när programmet startar och inga hjältar kommer att sparas till annan körning.');
        print('Om du vill använda en fil för att lagra hjältar starta programmet med argumentet -f.');
        print('');
  
        waitForEnter('Tryck ENTER för att starta.');       
        registerHeroDataManager(HeroDataManager()); 
        break;     
    } 

    registerHeroNetworkManager(HeroNetworkManager());
}


(StorageType,String?) _analyseArguments(List<String> arguments) {
  
  StorageType type = StorageType.none;
  String? filePath;

  if (arguments.isNotEmpty) {   
    
    String flag = arguments[0]; // första argumentet ska vara -t, -f 

    if (flag == '-t') {
      type = StorageType.test;
    } 
    else if (flag == '-f') {  
      type = StorageType.file;
      if (arguments.length > 1) {  // andra argumentet ska vara ett filnamn
        filePath = arguments[1];
      }
    } 
    else {
      print('Okänt argument: $flag');
    }
  }

  return (type, filePath);
}