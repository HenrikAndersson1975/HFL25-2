import 'dart:io';
import 'dart:convert';
import 'dialogs_helper.dart';
import 'package:v02/heroes_list_functions.dart';

void dialogSearchHero(List<Map<String, dynamic>> heroes) {


  bool isRunning = true;

  while(isRunning) {
   
    clearScreen();

    // frågar användaren efter namn eller del av namn
    print('\nSök hjälte:');
    stdout.write('Ange namn eller del av namn: ');
    String? partOfHeroName = stdin.readLineSync(encoding: utf8);  // encoding lades till för att kunna hantera åäö, med det fungerar ända inte i Windows Powershell trots (chcp 65001).

    if (partOfHeroName == null || partOfHeroName.isEmpty) {
      print('\nInget namn angivet.');    
    }
    else {    
      
      // hämtar hjältar från listan vars namn innehåller input
      List<Map<String, dynamic>> matchingHeroes = findHeroesByName(heroes, partOfHeroName, false);

      // visar resultatet av sökningen
      if (matchingHeroes.isEmpty) {
        print('\nIngen hjälte hittades med namnet som innehåller "$partOfHeroName".');
      } else {
        print('\nHittade ${matchingHeroes.length} ${matchingHeroes.length == 1 ? 'hjälte' : 'hjältar'} som matchar "$partOfHeroName".');
        printHeroes(matchingHeroes);
      }
    }

    // frågar användaren om den vill göra en ny sökning eller avsluta
    isRunning = acceptOrDecline('\nVill du göra en ny sökning? (j/n) ', 'j', 'n');
  }
}