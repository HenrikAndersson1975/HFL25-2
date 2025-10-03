
import 'package:v02/hero.dart';
import 'package:v02/extensions.dart';


List<Map<String, dynamic>> getPredefinedHeroes() {

  List<Map<String, dynamic>> heroes = [];

  heroes.addHeroToList(createHero("Lisa", 12, "kvinna", "god"));
  heroes.addHeroToList(createHero("Janne", 100, "man", "ond"));
  heroes.addHeroToList(createHero("Klas", 20, "man", "god"));
  heroes.addHeroToList(createHero("Petra", 88, "kvinna", "god"));

  return heroes;
} 


   