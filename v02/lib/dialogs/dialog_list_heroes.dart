import 'dialogs_helper.dart';
import '../extensions.dart';

/// Visar alla hjältar i listan, sorterade efter styrka (starkaste först)
void dialogListHeroes(List<Map<String, dynamic>> heroes) {

  clearScreen();

  print('--- Lista över hjältar ---');

  // Sorterar listan efter hjältarnas styrka, starkaste först
  heroes.orderHeroesByStrength();

  // Skriver ut alla hjältar i listan  
  heroes.forEach((hero) => hero.display());
   
  // Pausar tills användaren trycker Enter
  waitForEnter("\nTryck Enter för att återgå till meny.");
}



