
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/interfaces/hero_data_managing.dart';
import 'package:v04/services/unique_id_service.dart';


class MockHeroDataManager implements HeroDataManaging {
  
  final List<HeroModel> _heroList = [
    HeroModel(    
      id: getUniqueId(),
      name: "Martina Navratilova",
      powerstats: Powerstats(intelligence: 90, strength: 95, speed: 80, durability: 85, power: 100, combat: 75),
      biography: Biography(fullName: "Vansinne", alignment: "good"),
      appearance: Appearance(gender: "Female"),
    ),
    HeroModel(
      id: getUniqueId(),
      name: "Bosse Hansson",
      powerstats: Powerstats(intelligence: 70, strength: 65, speed: 75, durability: 60, power: 80, combat: 70),
      biography: Biography(fullName: "Bo Hansson", alignment: "bad"),
      appearance: Appearance(gender: "Male"),
    ),
    HeroModel(
      id: getUniqueId(),
      name: "Sven Jerring",
      powerstats: Powerstats(intelligence: 85, strength: 55, speed: 90, durability: 70, power: 95, combat: 65),
      biography: Biography(fullName: "Sven Jerring", alignment: "neutral"),
      appearance: Appearance(gender: "Male"),
    ),
    HeroModel(
      id: getUniqueId(),
      name: "Ivan Lendl",
      powerstats: Powerstats(intelligence: 63, strength: 78, speed: 52, durability: 85, power: 60, combat: 50),
      biography: Biography(fullName: "Ivan Lendl", alignment: "bad"),
      appearance: Appearance(gender: "Male"),
    ),
    HeroModel(
      id: getUniqueId(),
      name: "Jimmy Connors",
      powerstats: Powerstats(intelligence: 70, strength: 74, speed: 51, durability: 85, power: 60, combat: 50),
      biography: Biography(fullName: "James Connors", alignment: "bad"),
      appearance: Appearance(gender: "Male"),
    ),
    HeroModel(
      id: getUniqueId(),
      name: "Droppen",
      powerstats: Powerstats(intelligence: 100, strength: 50, speed: 50, durability: 100, power: 20, combat: 20),
      biography: Biography(fullName: "Mats Wilander", alignment: "good"),
      appearance: Appearance(gender: "man"),
    ),
  ];

  

  @override
  Future<bool> addHero(HeroModel hero) async {
    // Se till att hjälten har ett unikt id
    hero.id ??= getUniqueId();

    // Om id är null, ska vi kasta ett fel
    if (hero.id == null) {
      throw Exception('Hjälten kan inte ha ett null-id.');
    }

    // Kontrollera om hjälten redan finns i listan
    bool exists = _heroList.any((h) => h.id == hero.id);

    if (!exists) {    
      _heroList.add(hero);  // Spara hjälten till listan      
      return true;
    } else {
      throw Exception('Det finns redan en hjälte med samma id.');
    }
  }


  

  @override
  Future<bool> deleteHero(String heroId) async {
     
    int count = _heroList.length;

    _heroList.removeWhere((h) => h.id == heroId);
    bool anyDeleted = _heroList.length != count;
  
    return anyDeleted;  
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

  
}