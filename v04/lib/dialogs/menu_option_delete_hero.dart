import 'package:v04/dialogs/dialog_select_hero.dart';
import 'dialogs_helper.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/services/singletons_service.dart';
import 'package:v04/interfaces/hero_data_managing.dart';

Future<bool> menuOptionDeleteHero(List<HeroModel> heroes) async {

  int deletedCount = 0;

  List<HeroModel> remainingHeroes = [];
  remainingHeroes.addAll(heroes);

  bool exit = false;

  while (!exit) {

    clearScreen();

    print('--- Radera hjälte ---');

    // Användaren väljer en hjälte
    HeroModel? selectedHero = dialogSelectHero('', remainingHeroes, 'Ange vilken hjälte som du vill radera: ');

    // Om hjälte har valts....
    if (selectedHero != null) 
    {
      bool deleted = false;

      // Säkerställ att användaren vill ta bort hjälten
      bool deleteHero = acceptOrDecline('Är du säker på att du vill radera ${selectedHero.name}? (j/n) ', 'j', 'n');

      
      if (deleteHero) {

        // Försöker rader hjälte
        if (selectedHero.id != null) {          
          HeroDataManaging manager = getHeroDataManager();
          deleted = await manager.deleteHero(selectedHero.id!);

          if (deleted) {
            remainingHeroes.remove(selectedHero);
            deletedCount++;
          }
        }      

        // Visar resultat
        print(deleted ? 'Hjälte har tagits bort.':'Hjälte kunde inte tas bort.');
        
        // Om användaren vill ta bort annan
        exit = !acceptOrDecline('Vill du radera en annan hjälte? (j/n) ', 'j', 'n');
      }
    }
    else {
      exit = true;
    }
  }

  // true om någon hjälte har tagits bort
  return deletedCount>0;
}

