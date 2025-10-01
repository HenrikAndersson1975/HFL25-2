import 'dialogs_helper.dart';
import 'package:v02/heroes_list_functions.dart';

/// Visar alla hjältar i listan, sorterade efter styrka (starkaste först)
void dialogListHeroes(List<Map<String, dynamic>> heroes) {

  clearScreen();

  print('\nLista över hjältar:');

  // sorterar listan efter hjältarnas styrka, starkaste först
  orderHeroesByStrength(heroes);

  // skriver ut alla hjältar i listan
  printHeroes(heroes);
   
  // pausar tills användaren trycker Enter
  waitForEnter("\nTryck Enter för att återgå till meny.");
}



