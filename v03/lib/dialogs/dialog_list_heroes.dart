import 'package:v03/managers/hero_data_manager.dart';

import 'dialogs_helper.dart';
import 'package:v03/models/exports_hero_models.dart';

/// Visar alla hjältar i listan, sorterade efter styrka (starkaste först)
Future<void> dialogListHeroes() async {

  clearScreen();

  print('--- Lista över hjältar ---');

  HeroDataManager manager = HeroDataManager();

  // Sorterar listan efter hjältarnas styrka, starkaste först
  List<HeroModel> heroes = await manager.getHeroes();
  heroes.sort((a, b) {
      int strengthA = a.powerstats?.strength ?? 0;
      int strengthB = b.powerstats?.strength ?? 0;
      return strengthB.compareTo(strengthA); // Sortera i fallande ordning
    });

  // Skriver ut alla hjältar i listan  
    heroes.forEach((hero) {
          String? s = hero.toDisplayString();
          print(s);
        });    

  // Pausar tills användaren trycker Enter
  waitForEnter("\nTryck ENTER för att återgå till meny.");
}




 