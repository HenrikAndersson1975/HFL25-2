import 'dialogs_helper.dart';
import 'package:v03/models/exports_hero_models.dart';
import 'package:v03/services/hero_manager_service.dart';
import 'package:v03/interfaces/hero_data_managing.dart';

/// Visar alla hjältar i listan, sorterade efter styrka (starkaste först)
Future<void> dialogListHeroes() async {

  clearScreen();

  print('--- Lista över hjältar ---');

  HeroDataManaging manager = getHeroManager();

  // Sorterar listan efter hjältarnas styrka, starkaste först
  List<HeroModel> heroes = await manager.getHeroes();
  heroes.sort((a, b) {
      int strengthA = a.powerstats?.strength ?? 0;
      int strengthB = b.powerstats?.strength ?? 0;
      return strengthB.compareTo(strengthA); // Sortera i fallande ordning
    });

  print('Listan innehåller ${heroes.length} ${heroes.length == 1 ? 'hjälte' : 'hjältar'}.');

  // Skriver ut alla hjältar i listan  
  for (int i=0; i<heroes.length; i++) {
    String? s = heroes[i].toDisplayString(number: i+1);
          print(s);
  }

  // Pausar tills användaren trycker Enter
  waitForEnter("\nTryck ENTER för att återgå till meny.");
}




 