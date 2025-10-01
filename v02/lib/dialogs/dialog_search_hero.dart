import 'dart:io';
import 'dialogs_helper.dart';
import 'package:v02/heroes_list_functions.dart';

void dialogSearchHero(List<Map<String, dynamic>> heroes) {

  bool isRunning = true;

  while(isRunning) {
   
    clearScreen();

    // frågar användaren efter namn eller del av namn
    print('\nSök hjälte:');
    stdout.write('Ange namn eller del av namn: ');
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print('\nInget namn angivet.');    
    }
    else {
     
      List<Map<String, dynamic>> matchingHeroes = findHeroesByName(heroes, input, false);

      // visar resultatet av sökningen
      if (matchingHeroes.isEmpty) {
        print('\nIngen hjälte hittades med namnet som innehåller "$input".');
      } else {
        print('\nHittade ${matchingHeroes.length} ${matchingHeroes.length == 1 ? 'hjälte' : 'hjältar'} som matchar "$input".');
        printHeroes(matchingHeroes);
      }
    }

    // frågar användaren om den vill göra en ny sökning eller avsluta
    isRunning = acceptOrDecline('\nVill du göra en ny sökning? (j/n) ', 'j', 'n');
  }
}