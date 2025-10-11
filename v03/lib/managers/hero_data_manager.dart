import '../interfaces/hero_data_managing.dart';
import '../interfaces/hero_storage_managing.dart';
import '../models/hero_model.dart';

class HeroDataManager implements HeroDataManaging
{
  // Skapar instans, som sedan kommer att returneras varje gång HeroDataManager() anropas.
  static final HeroDataManager _instance = HeroDataManager._privateConstructor();

  // Privat konstruktor
  HeroDataManager._privateConstructor();

  HeroStorageManaging? _storage; // kommer sättas via factory

  // Factory-konstruktor som alltid returnerar samma instans
  factory HeroDataManager({HeroStorageManaging? storage}) {   
    if (_instance._storage == null && storage != null) {
      _instance._storage = storage; // sparar dependency första gången
    }
    return _instance;
  }


  List<HeroModel> _heroList = [];

  /// Laddar hjältar från storage till listan.
   @override
  Future<bool> loadHeroes() async {  
    try {   
      _heroList.clear();
      _heroList = await _storage?.load() ?? [];
      return true;
    } catch (e) {
      print('Fel när hjältar skulle laddas: $e');
      return false;
    }
  }


  /// Sparar en hjälte till listan och sparar sedan till storage.
  @override
  Future<bool> saveHero(HeroModel hero) async {
    try {
      hero.id = _getNextHeroId();
      _heroList.add(hero);

      SaveType? saveType = _storage?.getSaveType();

      if (saveType == SaveType.addNewItem) {
        await _storage?.addNewItem(hero);  // om storage endast vill ha nytt element
      }
      else if (saveType == SaveType.replaceItemCollection) {
        await _storage?.replaceItemCollection(_heroList);  // om storage byter ut hela listan
      }

      return true;
    } catch (e) {
      print('Fel vid sparande av hjälte: $e');
      return false;
    }
  }



  @override
  Future<List<HeroModel>> findHeroesByName(String pattern, bool caseSensitive) async {
   
    String searchPattern = caseSensitive ? pattern : pattern.toLowerCase();

    // Sök i listan efter hjältar vars namn innehåller söksträngen
    return _heroList.where((hero) {
      String name = hero.name ?? '';
      if (!caseSensitive) {
        name = name.toLowerCase();
      }   
      return name.contains(searchPattern);  // Kollar om söksträngen finns i namnet
    }).toList();
  }
  

  @override
  Future<List<HeroModel>> getHeroes() async {
    return _heroList;
  }


  int _getNextHeroId() {       
    int maxId = 0;
    for (var hero in _heroList) {
      int id = hero.id ?? 0;
      if (id > maxId) {
        maxId = id;
      }
    }
    return maxId + 1; // nästa tillgängliga id   
  }
}