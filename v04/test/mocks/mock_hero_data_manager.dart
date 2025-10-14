
import 'package:v03/models/exports_hero_models.dart';
import 'package:v03/interfaces/hero_data_managing.dart';


class MockHeroDataManager implements HeroDataManaging {
  
  final List<HeroModel> _heroList = [
    HeroModel(    
      id: 1,
      name: "Martina Navratilova",
      powerstats: Powerstats(intelligence: 90, strength: 95, speed: 80, durability: 85, power: 100, combat: 75),
      biography: Biography(fullName: "Vansinne", alignment: "god"),
      appearance: Appearance(gender: "kvinna"),
    ),
    HeroModel(
      id: 2,
      name: "Bosse Hansson",
      powerstats: Powerstats(intelligence: 70, strength: 65, speed: 75, durability: 60, power: 80, combat: 70),
      biography: Biography(fullName: "Bo Hansson", alignment: "ond"),
      appearance: Appearance(gender: "man"),
    ),
    HeroModel(
      id: 3,
      name: "Sven Jerring",
      powerstats: Powerstats(intelligence: 85, strength: 55, speed: 90, durability: 70, power: 95, combat: 65),
      biography: Biography(fullName: "Sven Jerring", alignment: "neutral"),
      appearance: Appearance(gender: "man"),
    ),
    HeroModel(
      id: 4,
      name: "Ivan Lendl",
      powerstats: Powerstats(intelligence: 63, strength: 78, speed: 52, durability: 85, power: 60, combat: 50),
      biography: Biography(fullName: "Ivan Lendl", alignment: "ond"),
      appearance: Appearance(gender: "man"),
    ),
    HeroModel(
      id: 5,
      name: "Jimmy Connors",
      powerstats: Powerstats(intelligence: 70, strength: 74, speed: 51, durability: 85, power: 60, combat: 50),
      biography: Biography(fullName: "James Connors", alignment: "ond"),
      appearance: Appearance(gender: "man"),
    ),
    HeroModel(
      id: 6,
      name: "Droppen",
      powerstats: Powerstats(intelligence: 100, strength: 50, speed: 50, durability: 100, power: 20, combat: 20),
      biography: Biography(fullName: "Mats Wilander", alignment: "god"),
      appearance: Appearance(gender: "man"),
    ),
  ];

  /// Laddar hjältar (mock: gör inget, listan finns redan)
  @override
  Future<bool> loadHeroes() async {
    return true;
  }

  

  /// Spara hjälte (lägg till i listan)
  @override
  Future<bool> saveHero(HeroModel hero) async {
    hero.id ??= _getNextHeroId();
    _heroList.add(hero);
    return true;
  }

  /// Sök hjältar efter namn (case-insensitive om caseSensitive=false)
  @override
  Future<List<HeroModel>> findHeroesByName(String pattern, bool caseSensitive) async {
    String searchPattern = caseSensitive ? pattern : pattern.toLowerCase();

    return _heroList.where((hero) {
      String name = hero.name ?? '';
      if (!caseSensitive) name = name.toLowerCase();
      return name.contains(searchPattern);
    }).toList();
  }

  /// Hämta alla hjältar
  @override
  Future<List<HeroModel>> getHeroes() async => _heroList;

  /// Hjälpfunktion för att generera nästa id
  int _getNextHeroId() {
    int maxId = 0;
    for (var hero in _heroList) {
      int id = hero.id ?? 0;
      if (id > maxId) maxId = id;
    }
    return maxId + 1;
  }
}