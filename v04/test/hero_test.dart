
import 'package:v03/models/exports_hero_models.dart';
import 'mocks/mock_hero_data_manager.dart';

Future<void> main() async {
  final manager = MockHeroDataManager();

  print("\nLägg till ny hjälte:");
  await manager.saveHero(HeroModel(
    name: "Phantom Blaze",
    powerstats: Powerstats(intelligence: 70),
    biography: Biography(fullName: "Finn Phantom"),
    appearance: Appearance(gender: "man"),
  ));

  print("\nSkapa hjälte från json:");
  HeroModel theJsonHero = HeroModel.fromJson(_jsonHero);

  print("\nLägg till json-hjälten:");
  await manager.saveHero(theJsonHero);

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
