import 'package:v03/models/exports_hero_models.dart';
import 'dialogs_helper.dart';
import 'package:v03/services/hero_manager_service.dart';
import 'package:v03/interfaces/hero_data_managing.dart';

Future<void> dialogInit() async {

  clearScreen();

  HeroDataManaging manager = getHeroManager();
  
  // Ladda hjältar från storage till hjältelistan 
  print('Läser in hjältar...');
  bool success = await manager.loadHeroes();
  if (success) { print('Klart.'); }
  print('');

  List<HeroModel> heroes = await manager.getHeroes();
  
  // Skriv ut antal hjältar som har laddats
  print('Programmet startar med ${heroes.length} ${heroes.length == 1 ? 'hjälte' : 'hjältar'}.');
  print('');
  waitForEnter('Tryck ENTER för att fortsätta');
}