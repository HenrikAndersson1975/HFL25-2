import 'dialogs_helper.dart';
import 'package:v02/hero_creator.dart';
import 'package:v02/heroes_list_functions.dart';



void dialogAddHero(List<Map<String, dynamic>> heroes) {

// todo: implementera dialog för att lägga till hjälte med användarinmatning



  clearScreen();

  int id = getNextHeroId(heroes);

  Map<String, dynamic> newHero = createRandomHero(id);

  // lägg till den nya hjälten i listan
  heroes.add(newHero);


  print('\nNy hjälte tillagd:');
  printHero(newHero);

  waitForEnter( "\nTryck Enter för att återgå till meny.");

}




