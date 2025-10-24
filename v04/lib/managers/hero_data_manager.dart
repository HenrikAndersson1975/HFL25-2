import 'package:v04/interfaces/hero_storage_managing.dart';
import 'package:v04/services/unique_id_service.dart';
import '../interfaces/hero_data_managing.dart';
import '../models/hero_model.dart';
import 'dart:io';

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

  final List<HeroModel> _heroList = [];

  
  @override
  Future<bool> addHero(HeroModel hero) async {
    try {

      // Om id är null, har användare skapat ny hjälte. Tilldela ett unikt id.
      hero.id ??= getUniqueId();
      
      // Hämta lista
      List<HeroModel> list = await getHeroes();

      // Kontrollera om det finns hjälte med samma id
      bool exists = list.any((h) => h.id == hero.id);
 
      if (!exists) {    
        _heroList.add(hero);  // spara till lista
        _storage?.upsertHero(hero);  // spara till storage
        return true;
      }
      else {
        throw Exception('Det finns hjälte med samma id.');
      }

    } catch (e) {
      stdout.write(e);
      return false;
    }   
   
  }


  @override
  Future<bool> deleteHero(String heroId) async {
    
    List<HeroModel> list = await getHeroes();
    int count = list.length;

    list.removeWhere((h) => h.id == heroId);
    bool anyDeleted = list.length != count;

    if (anyDeleted) {
      await _storage?.deleteHero(heroId);
    }
      
    return anyDeleted;
  }


  @override
  Future<List<HeroModel>> findHeroesByName(String pattern, bool caseSensitive) async {
   
    String searchPattern = caseSensitive ? pattern : pattern.toLowerCase();

    List<HeroModel> list = await getHeroes();

    // Sök i listan efter hjältar vars namn innehåller söksträngen
    return list.where((hero) {
      String name = hero.name ?? '';
      if (!caseSensitive) {
        name = name.toLowerCase();
      }   
      return name.contains(searchPattern);  // Kollar om söksträngen finns i namnet
    }).toList();
  }
  

  @override
  Future<List<HeroModel>> getHeroes() async {

    // Om lista är tom, kan det bero på att den inte har synkats mot storage
    if (_heroList.isEmpty) {  
      List<HeroModel> list = await _storage?.getHeroes() ?? [];
      if (list.isNotEmpty) {
        _heroList.addAll(list);
      }
    }

    return _heroList;
  }
}