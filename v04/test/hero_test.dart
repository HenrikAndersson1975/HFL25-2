
import 'package:v04/models/exports_hero_models.dart';
import 'mocks/mock_hero_data_manager.dart';
import 'mocks/mock_hero_network_manager.dart';
//import 'package:v04/managers/hero_network_manager.dart';

Future<void> main() async {


  // data
  {
    final manager = MockHeroDataManager();

    
    print("\nLägg till ny hjälte:");
    await manager.addHero(HeroModel(
      name: "Phantom Blaze",
      powerstats: Powerstats(intelligence: 70),
      biography: Biography(fullName: "Finn Phantom"),
      appearance: Appearance(gender: "Male"),
    ));

    print("\nSkapa hjälte från json:");
    HeroModel theJsonHero = HeroModel.fromJson(_jsonHero);

    print("\nLägg till json-hjälten:");
    await manager.addHero(theJsonHero);

    print("\nLista alla hjältar:");
    for (var hero in await manager.getHeroes()) {
      print(hero.toDisplayString());
    }

    print("\nSök efter hjältar med 'a' i namnet:");
    final results = await manager.findHeroesByName("a", false);
    for (var hero in results) {
      print(hero.toDisplayString());
    }
  }
  

  // network mock
  {
    final manager = MockHeroNetworkManager();

    print("\nSök efter hjältar med 'b' i namnet:");
    final (success, results) = await manager.findHeroesByName("b");
    if (success) {
    for (var hero in results) {
      print(hero.toDisplayString());
    }}
    else {
      print('Gick inte!');
    }
  }
  
  // network 
  /*{
    final manager = HeroNetworkManager();

    print("\nSök efter hjältar med 'b' i namnet:");
    final (success, results) = await manager.findHeroesByName("b");
    if (success) {
    for (var hero in results) {
      print(hero.toDisplayString());
    }}
    else {
      print('Gick inte!');
    }
  }*/
}

Map<String,dynamic> _jsonHero = {
  "response": "success",
  "id": "70",
  "name": "JsonHero",
  "powerstats": {
    "intelligence": "100",
    "strength": "26",
    "speed": "27",
    "durability": "50",
    "power": "47",
    "combat": "100"
  },
  "biography": {
    "full-name": "Bruce Wayne",
    "alter-egos": "No alter egos found.",
    "aliases": [
      "Insider",
      "Matches Malone"
    ],
    "place-of-birth": "Crest Hill, Bristol Township; Gotham County",
    "first-appearance": "Detective Comics #27",
    "publisher": "DC Comics",
    "alignment": "god"
  },
  "appearance": {
    "gender": "man",
    "race": "Human",
    "height": [
      "6'2",
      "188 cm"
    ],
    "weight": [
      "210 lb",
      "95 kg"
    ],
    "eye-color": "blue",
    "hair-color": "black"
  },
  "work": {
    "occupation": "Businessman",
    "base": "Batcave, Stately Wayne Manor, Gotham City; Hall of Justice, Justice League Watchtower"
  },
  "connections": {
    "group-affiliation": "Batman Family, Batman Incorporated, Justice League, Outsiders, Wayne Enterprises, Club of Heroes, formerly White Lantern Corps, Sinestro Corps",
    "relatives": "Damian Wayne (son), Dick Grayson (adopted son), Tim Drake (adopted son), Jason Todd (adopted son), Cassandra Cain (adopted ward), Martha Wayne (mother, deceased)"
  },
  "image": {
    "url": "https://www.superherodb.com/pictures2/portraits/10/100/639.jpg"
  }
};
