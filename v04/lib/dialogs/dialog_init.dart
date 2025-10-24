import 'package:v04/models/exports_hero_models.dart';
import 'dialogs_helper.dart';
import 'package:v04/services/singletons_service.dart';
import 'package:v04/interfaces/hero_data_managing.dart';

Future<void> dialogInit() async {

  clearScreen();

  HeroDataManaging manager = getHeroDataManager();
  
  

  // Ladda hjältar från storage till hjältelistan 
  print('Läser in hjältar...');
 // bool success = await manager.loadHeroes();
 // if (success) { print('Klart.'); }
  print('');

  List<HeroModel> heroes = await manager.getHeroes();
  
  // Skriv ut antal hjältar som har laddats
  print('Programmet startar med ${heroes.length} ${heroes.length == 1 ? 'hjälte' : 'hjältar'}.');
  print('');
  waitForEnter('Tryck ENTER för att fortsätta');
}