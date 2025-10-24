import 'dart:io';
import 'dart:convert';
import 'package:v04/models/exports_hero_models.dart';
import 'dialogs_helper.dart';
import 'package:v04/services/singletons_service.dart';
import 'package:v04/interfaces/hero_data_managing.dart';

/// 
Future<void> dialogSearchHero() async {

  bool isRunning = true;

  while(isRunning) {
   
    clearScreen();
    print('--- Sök hjälte ---');

    // Frågar användaren efter namn eller del av namn 
    stdout.write('Ange namn eller del av namn: ');
    String? partOfHeroName = stdin.readLineSync(encoding: utf8);  // encoding lades till för att kunna hantera åäö, med det fungerar ända inte i Windows Powershell trots (chcp 65001).

    if (partOfHeroName == null || partOfHeroName.isEmpty) {
      print('Inget namn angivet.');    
    }
    else {    
      HeroDataManaging manager = getHeroDataManager();
      List<HeroModel> matchingHeroes = await manager.findHeroesByName(partOfHeroName, false);

      clearScreen();
      print('--- Sök hjälte ---');

      // Visar resultatet av sökningen
      if (matchingHeroes.isEmpty) {
        print('Ingen hjälte hittades med namn som innehåller "$partOfHeroName".');
      } else {
        print('Hittade ${matchingHeroes.length} ${matchingHeroes.length == 1 ? 'hjälte' : 'hjältar'} som matchar "$partOfHeroName".');   
        for (int i=0; i<matchingHeroes.length; i++) {        
          String? s = matchingHeroes[i].toDisplayString();
          print(s);
        }   
      }
    }

    // Frågar användaren om den vill göra en ny sökning eller avsluta
    isRunning = acceptOrDecline('\nVill du göra en ny sökning? (j/n) ', 'j', 'n');
  }
}

