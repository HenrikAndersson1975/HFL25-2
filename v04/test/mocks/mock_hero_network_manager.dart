import 'package:v04/interfaces/hero_network_managing.dart';
import 'package:v04/models/exports_hero_models.dart';

class MockHeroNetworkManager implements HeroNetworkManaging {
  

  @override
  Future<(bool success, List<HeroModel> heroes)> findHeroesByName(String pattern) async  {
   
    bool caseSensitive = false;
    String searchPattern = caseSensitive ? pattern : pattern.toLowerCase();

    List<HeroModel> list =  _getHeroes();

    //
    await Future.delayed(Duration(seconds: 2));

    bool success = true;

    // Sök i listan efter hjältar vars namn innehåller söksträngen
    list = list.where((hero) {
      String name = hero.name ?? '';
      if (!caseSensitive) {
        name = name.toLowerCase();
      }  
      return name.contains(searchPattern);  // Kollar om söksträngen finns i namnet
    }).toList();

    return (success, list);
  }


  List<HeroModel> _getHeroes() {
    final List<HeroModel> heroList = [
    HeroModel(    
      id: "1",
      name: "Hero One",
      powerstats: Powerstats(intelligence: 0, strength: 0, speed: 0, durability: 0, power: 0, combat: 0),
      biography: Biography(fullName: "H1", alignment: "good"),
      appearance: Appearance(gender: "Male"),
    ),
    HeroModel(
      id: "2",
      name: "Hero Two",
      powerstats: Powerstats(intelligence: 70, strength: 25, speed: 75, durability: 60, power: 80, combat: 70),
      biography: Biography(fullName: "H2", alignment: "neutral"),
      appearance: Appearance(gender: "Female"),
    ),
    HeroModel(
      id: "3",
      name: "Hero Three",
      powerstats: Powerstats(intelligence: 85, strength: 15, speed: 90, durability: 70, power: 95, combat: 65),
      biography: Biography(fullName: "H3", alignment: "neutral"),
      appearance: Appearance(gender: "Male"),
    ),
    HeroModel(
      id: "4",
      name: "Hero Four",
      powerstats: Powerstats(intelligence: 63, strength: 28, speed: 52, durability: 85, power: 60, combat: 50),
      biography: Biography(fullName: "H4", alignment: "bad"),
      appearance: Appearance(gender: "Male"),
    ),
    HeroModel(
      id: "5",
      name: "Hero Five",
      powerstats: Powerstats(intelligence: 70, strength: 4, speed: 51, durability: 85, power: 60, combat: 50),
      biography: Biography(fullName: "H5", alignment: "bad"),
      appearance: Appearance(gender: "Male"),
    )   
  ];
  return heroList;
  }
}