

import 'package:v04/dialogs/exports_dialogs.dart'; 
import 'package:v04/managers/hero_data_manager.dart';
import 'package:v04/managers/hero_file_manager.dart';
import 'package:v04/services/singletons_service.dart';

import '../test/mocks/mock_hero_data_manager.dart';

import 'package:v04/managers/hero_network_manager.dart';

import 'package:v04/interfaces/hero_storage_managing.dart';


void main(List<String> arguments) async {
  



// todo
// ska lägga till att man kan söka hjälte via api

// inga dubletter
// hantera id!!!
// resutat kan sparas till lokal lista
// man ska kunna ta bort hjälte från lokal lista
// ... se till att inte read/write kan göras samtidigt
// ska kunna lista god och onda jhjältar var för sig


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
  addHero, listHeroes, searchHero, exit, testhttp
}

/// Menyloopen
Future<void> _runMainMenu() async {
  bool isRunning = true;

  while (isRunning) {
    MainMenuAction menuChoice = dialogMenu<MainMenuAction>(
      '=== MENY ===',
      [
        MenuOption(MainMenuAction.testhttp, 'Sök hjälte ... test http'),
        MenuOption(MainMenuAction.addHero, 'Skapa hjälte och spara i lokal lista'),
        MenuOption(MainMenuAction.listHeroes, 'Visa hjältar i lokal lista'),
        MenuOption(MainMenuAction.searchHero, 'xxxxSök hjälte i lokal lista'),
        MenuOption(MainMenuAction.exit, 'Avsluta'),
      ],
      'Välj ett alternativ: ',
    );

    switch (menuChoice) {

      case MainMenuAction.testhttp: 
        //await dialogSearchHeroTESTHTTP();
        break;

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
  test, file, none
}





void _registerManagers(StorageType storageType, String? filePath) {


    switch (storageType) {

      // om man vill starta i testläge
      case StorageType.test:   
        print('Programmet startar i testläge. En testlista med hjältar kommer att laddas.'); 
        waitForEnter('Tryck ENTER för att starta.');     
        registerHeroDataManager(MockHeroDataManager());   
        break;
      
      // om man vill använda fil för att läsa och skriva hjältar till
      case StorageType.file:
        filePath = dialogFilePath('Du har angivit att du vill att programmet ska använda en fil för att läsa från och skriva till.', suggestedFile: filePath);       
        HeroStorageManaging storage = HeroFileManager(filePath ?? 'heroes.json');
        registerHeroDataManager(HeroDataManager(storage: storage));  
        break;
   
      default:  
        print('Du har valt att köra programmet utan lagring. Inga hjältar finns när programmet startar och inga hjältar kommer att sparas till annan körning.');
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
    else {
      print('Okänt argument: $flag');
    }
  }

  return (type, filePath);
}