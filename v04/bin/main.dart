import 'package:v04/interfaces/hero_data_managing.dart';
import 'package:v04/interfaces/hero_network_managing.dart';
import 'package:v04/interfaces/hero_storage_managing.dart';
import 'package:v04/managers/hero_data_manager.dart';
import 'package:v04/managers/hero_file_manager.dart';
import 'package:v04/managers/hero_network_manager.dart';
import 'package:v04/services/singletons_service.dart';
import 'package:v04/dialogs/exports_menu_options.dart';
import 'package:v04/dialogs/exports_dialogs.dart'; 
import '../test/mocks/mock_hero_data_manager.dart';
import 'package:v04/models/hero_model.dart';


void main(List<String> arguments) async {
  
  // 
  await _init(arguments);

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

Future<void> _init(List<String> arguments) async {

  clearScreen();  

  // analysera första startargument 
  StorageType storageType = _analyseFirstArgument(arguments);
  //
  // -t 
  // -f ???
  
  // Avgör om lagring ska användas
  String? filePath; 
  switch (storageType) {
    case StorageType.test:
      break;
    case StorageType.file:
      filePath = _analyseSecondArgument(arguments);  // kollar om andra argumentet är ett filnamn
      break; 
    default:
      // Användaren har inte angivit något startargument
      bool useStorage = acceptOrDecline("Vill du använda en fil för att läsa in hjältar från och spara hjältar till? (j/n) ", "j", "n");
      if (useStorage) storageType = StorageType.file;
      break;
  }


  // Avgör vilken fil som ska användas för lagring
  if (storageType == StorageType.file) {
    filePath = dialogFilePath("Fil för att lagra hjältar", suggestedFile: filePath); // Om filnamn har angivits som startargument, skickas det med som förslag

    if (filePath == null) {
      print('\nDu har inte angivit något giltigt filnamn, programmet kommer att köras utan lagring.');  
      storageType = StorageType.none;  
    }
  }


  // Registrera singletons
  switch (storageType) {    
    case StorageType.test:   
      _registerMockDataManager();
      break;
    case StorageType.file:         
      _registerDataManager(filePath);
      break;
    default:         
      _registerDataManager(null);    
      break;     
  } 
  _registerNetworkManager();
  

  await _startMessagePreLoading(storageType);
  await _startMessagePostLoading(storageType);
}


// Meddelande före inläsning av hjältelista
Future<void> _startMessagePreLoading(StorageType storageType) async {
  switch(storageType) {
    case StorageType.test: 
      print('Programmet startar i testläge. En testlista med hjältar kommer att laddas.');
      print(''); 
      waitForEnter('Tryck ENTER för att starta.');  
      break;
    case StorageType.file: 
      break;
    case StorageType.none:  
      print('Inga hjältar finns när programmet startar och inga hjältar kommer att sparas till annan körning.');      
      print(''); 
      waitForEnter('Tryck ENTER för att starta.');  
      break;
  }
} 

// Meddelande efter inläsning av hjältelista
Future<void> _startMessagePostLoading(StorageType storageType) async {
 
  if (storageType != StorageType.none)
  {
    clearScreen();

    HeroDataManaging manager = getManager<HeroDataManaging>();
  
    // Ladda hjältar från storage till hjältelistan 
    print('Läser in hjältar...');
    List<HeroModel> heroes = await manager.getHeroes();
    print('Klart.');
    print('');
  
    // Skriv ut antal hjältar som har laddats
    print('Programmet startar med ${heroes.length} ${heroes.length == 1 ? 'hjälte' : 'hjältar'}.');
    print('');
    waitForEnter('Tryck ENTER för att fortsätta');
  }
}


void _registerMockDataManager() {
  HeroDataManaging manager = MockHeroDataManager();
   registerManager(manager);   
}
void _registerDataManager(String? filePath) {
  HeroStorageManaging? storage = filePath != null ? HeroFileManager(filePath) : null;
  HeroDataManaging manager = HeroDataManager(storage: storage);
  registerManager(manager); 
}
void _registerNetworkManager() {
  HeroNetworkManaging manager = HeroNetworkManager();
  registerManager(manager);
}


StorageType _analyseFirstArgument(List<String> arguments) { 
  StorageType type = StorageType.none;
  if (arguments.isNotEmpty) {   
    
    String flag = arguments[0]; // första argumentet ska vara -t, -f 

    if (flag == '-t') {
      type = StorageType.test;
    } 
    else if (flag == '-f') {  
      type = StorageType.file;     
    } 
    else {
      print('Okänt argument: $flag');
    }
  }
  return type;
}
String? _analyseSecondArgument(List<String> arguments) { 
  String? value;
  if (arguments.isNotEmpty && arguments.length>1) {   
    value = arguments[1];   
  }
  return value;
}