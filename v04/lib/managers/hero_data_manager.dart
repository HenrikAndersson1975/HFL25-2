import 'package:v04/interfaces/hero_storage_managing.dart';
import 'package:v04/services/unique_id_service.dart';
import 'package:v04/interfaces/hero_data_managing.dart';
import 'package:v04/models/hero_model.dart';
import 'dart:io';

class HeroDataManager implements HeroDataManaging
{
  // Skapar instans, som sedan kommer att returneras varje gång HeroDataManager() anropas.
  static final HeroDataManager _instance = HeroDataManager._privateConstructor();

  // Privat konstruktor
  HeroDataManager._privateConstructor();

  final List<HeroModel> _heroList = []; // lista i minnet ... borde kanske inte ha den alls om _storage finns
  HeroStorageManaging? _storage; // kommer sättas via factory

  // Factory-konstruktor som alltid returnerar samma instans
  factory HeroDataManager({HeroStorageManaging? storage}) {   
    if (_instance._storage == null && storage != null) {
      _instance._storage = storage; // sparar dependency första gången
    }
    return _instance;
  }

  @override
  Future<bool> addHero(HeroModel hero) async {

    bool updated = false; // Om det gick att spara till lokal lista

    try {

      // Om id är null, har användare skapat ny hjälte. Tilldela ett unikt id.
      hero.id ??= getUniqueId();
      
      // Hämta lista
      List<HeroModel> list = await getHeroes();

      // Kontrollera om det finns hjälte med samma id
      bool exists = list.any((h) => h.id == hero.id);
 
      if (!exists) {    

        updated = true;

        // Lokal lista
        _heroList.add(hero); // spara till lista

        // Databas
        if (_storage != null) {
          bool storageUpdated = await _storage!.upsertHero(hero);  // spara till storage
          if (!storageUpdated) { 
            throw Exception('Varning ändring har inte sparats till databas.');
          }
        }  
      }
      else {
        throw Exception('Det finns hjälte med samma id.');
      }
    } catch (e) {
      stdout.write(e);      
    }    

    return updated;
  }


  @override
  Future<bool> deleteHero(String heroId) async {
    
    bool updated = false; // Om det har tagits bort från lokal lista

    try {

      List<HeroModel> list = await getHeroes();
      int count = list.length;

      // Lokal lista
      list.removeWhere((h) => h.id == heroId);
      updated = list.length != count;

      // Databas
      if (updated && _storage != null) {
        bool storageUpdated = await _storage!.deleteHero(heroId);
        if (!storageUpdated) {
          throw Exception('Varning ändring har inte sparats till databas.');
        }
      }
    }
    catch (e) {
      stdout.write(e);      
    }

    return updated;
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