
import 'package:v02/hero_creator.dart';
import 'package:v02/heroes_list_functions.dart';

List<Map<String, dynamic>> getPredefinedHeroes() {

  List<Map<String, dynamic>> heroes = [];

  addHeroToList(createHero("Lisa", 12, "Kvinna", "god"), heroes);
  addHeroToList(createHero("Janne", 100, "Man", "ond"), heroes);
  addHeroToList(createHero("Klas", 20, "Man", "god"), heroes);
  addHeroToList(createHero("Petra", 88, "Kvinna", "god"), heroes);

  return heroes;
} 


   