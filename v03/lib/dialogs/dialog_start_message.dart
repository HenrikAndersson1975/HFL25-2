import 'package:v03/managers/exports_data_managing.dart';
import 'package:v03/models/exports_hero_models.dart';
import 'dialogs_helper.dart';

Future<void> dialogStartMessage() async {

  HeroDataManaging manager = HeroDataManager();
  
  List<HeroModel> heroes = await manager.getHeroes();

  // Skriv ut antal hjältar som har laddats
  clearScreen();
  print('--- Hjältelista initierad ---');
  print('Programmet startar med ${heroes.length} ${heroes.length == 1 ? 'hjälte' : 'hjältar'}.');
  print('');
  waitForEnter('Tryck ENTER för att fortsätta');
}