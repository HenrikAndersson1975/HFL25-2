import 'package:v03/dialogs/exports_dialogs.dart'; 
import 'package:v03/managers/exports_data_managing.dart';
import 'package:v03/managers/exports_storage_managing.dart';


void main(List<String> arguments) async {
  
  clearScreen();  

  String? filePath; // borde fråga om man vill ladda från fil ändå.... borde ha med argument igen

  //dialogFilePath("", suggestedFile)
  // ladda spara till fil verkar inte fungera i nuläget

  // 
  HeroStorageManaging storage = HeroFileManager(filePath ?? 'heroes.json'); // skapar storage, i detta fall filhantering
  HeroDataManager heroDataManager = HeroDataManager(storage: storage);  // injicerar storage till hjältelisthanteraren

  // ladda hjältar från storage till hjältelistan 
  await heroDataManager.loadHeroes();

  // Visa startmeddelande
  await dialogStartMessage();

  await runMainMenu();

  clearScreen();
  print('Programmet har avslutats.');
}


/// Alternativ i programmets huvudmeny
enum MainMenuAction {
  addHero, listHeroes, searchHero, exit
}


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