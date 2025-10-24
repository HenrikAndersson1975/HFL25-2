import 'dialogs_helper.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/services/singletons_service.dart';
import 'package:v04/interfaces/hero_data_managing.dart';
import 'dialog_create_hero.dart';

Future<void> menuOptionCreateHero() async {


  HeroModel? hero = dialogCreateHero();   
    
  if (hero != null) {

    clearScreen();
    print('--- Ny hjälte har skapats ---');
    print(hero.toDisplayString());
    print('');

    print('Hjälte sparas...');
    try {
      // Försök att lägga till hjälten till listan
      HeroDataManaging manager = getHeroDataManager();
      await manager.addHero(hero);
      print('OK.');
    }
    catch (e) {
      print(e);
    }
    
    print('');
    waitForEnter('Tryck ENTER för att fortsätta');
  }
}

