import 'dart:io';
import 'dart:convert';
import 'dialogs_helper.dart';
import '../extensions.dart';


/// 
void dialogSearchHero(List<Map<String, dynamic>> heroes) {

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
      
      // Hämtar hjältar från listan vars namn innehåller input
      List<Map<String, dynamic>> matchingHeroes = heroes.findHeroesByName(partOfHeroName, false);

      clearScreen();
      print('--- Sök hjälte ---');

      // Visar resultatet av sökningen
      if (matchingHeroes.isEmpty) {
        print('Ingen hjälte hittades med namnet som innehåller "$partOfHeroName".');
      } else {
        print('Hittade ${matchingHeroes.length} ${matchingHeroes.length == 1 ? 'hjälte' : 'hjältar'} som matchar "$partOfHeroName".');            
        matchingHeroes.forEach(printHero);         
      }
    }

    // Frågar användaren om den vill göra en ny sökning eller avsluta
    isRunning = acceptOrDecline('\nVill du göra en ny sökning? (j/n) ', 'j', 'n');
  }
}

