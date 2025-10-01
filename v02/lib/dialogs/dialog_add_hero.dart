import 'dialogs_helper.dart';
import 'package:v02/hero_creator.dart';
import 'package:v02/heroes_list_functions.dart';



void dialogAddHero(List<Map<String, dynamic>> heroes) {

// todo: implementera dialog för att lägga till hjälte med användarinmatning



  clearScreen();

  

  Map<String, dynamic> newHero = createRandomHero();  // <--- ska ersättas med att man matar in olika egenskaper

  //newHero = createHero(name, strength, gender, alignment);


  addHeroToList(newHero, heroes);

  // lägg till den nya hjälten i listan
  heroes.add(newHero);


  print('\nNy hjälte tillagd:');
  printHero(newHero);

  waitForEnter( "\nTryck Enter för att återgå till meny.");

}




