import 'package:v03/dialogs/exports_dialogs.dart'; 
import 'package:v03/interfaces/hero_data_managing.dart';
import 'package:v03/managers/hero_data_manager.dart';
import 'package:v03/interfaces/hero_storage_managing.dart';
import 'package:v03/managers/hero_file_manager.dart';
import '../test/mocks/mock_hero_data_manager.dart';
import 'package:get_it/get_it.dart';


void main(List<String> arguments) async {
  
  clearScreen();  

  final getIt = GetIt.instance;

  // analysera startargument
  var (runMode, filePath) = _handleArguments(arguments);

 // initiera datahantering
 {  
    switch (runMode) {

      // om man vill starta i testläge
      case RunMode.test:   
        print('Programmet startar i testläge. En testlista med hjältar kommer att laddas.');
        getIt.registerLazySingleton<HeroDataManaging>(() => MockHeroDataManager());        
        break;
      
      // om man vill starta med att ladda en fil, eller om man inte har angivit giltigt startargument
      case RunMode.file:
      default:
        if (runMode == RunMode.file) {
          filePath ??= dialogFilePath('Du har angivit att du vill starta programmet med att läsa in hjältar från en fil.');     
        }    
        filePath ??= 'heroes.json';  // programmet använder heroes.json om ingen fil har angivits            
        HeroStorageManaging storage = HeroFileManager(filePath); // skapar storage, i detta fall filhantering   
        getIt.registerLazySingleton<HeroDataManaging>(() => HeroDataManager(storage: storage));  // registrerar hanterare för hjältelista    
    }
  }

  // Visa startmeddelande
  await dialogInit();

  // Gå till menyloopen
  await runMainMenu();

  clearScreen();
  print('Programmet har avslutats.');
}


/// Alternativ i programmets huvudmeny
enum MainMenuAction {
  addHero, listHeroes, searchHero, exit
}

/// Menyloopen
Future<void> runMainMenu() async {
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

enum RunMode {
  test, file, other
}


(RunMode,String?) _handleArguments(List<String> arguments) {
  
  RunMode runMode = RunMode.other;
  String? filePath;

  if (arguments.isNotEmpty) {   
    
    String flag = arguments[0]; // första argumentet ska vara -t eller -f

    if (flag == '-t') {
      runMode = RunMode.test;
    } 
    else if (flag == '-f') {  
      runMode = RunMode.file;
      if (arguments.length > 1) {  // andra argumentet ska vara ett filnamn
        filePath = arguments[1];
      }
    } else {
      print('Okänt argument: $flag');
    }
  }

  return (runMode, filePath);
}