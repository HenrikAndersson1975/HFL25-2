import 'package:v04/interfaces/hero_storage_managing.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'dart:convert';
import 'package:v04/services/file_service.dart';


class HeroFileManager implements HeroStorageManaging {

  // FileService-instans som hanterar filen 'filePath'
  final FileService _fileService;
  
  // Factory för att skapa instans av HeroFileManager
  factory HeroFileManager(String filePath) {
    return HeroFileManager._(FileService(filePath));
  }
  
  // Privat konstruktor
  HeroFileManager._(this._fileService);

  @override
  Future<bool> upsertHero(HeroModel hero) async {

    // Vill egentligen bara lägga till en hjälte till storage.
    // Men eftersom en fil används för att lagra alla hjältar, måste hela filen skrivas om.
    // Alternativt hade man kunnat ha en hjälte per fil.

    if (hero.id?.isEmpty ?? true)
    {
      throw Exception('Hjälte saknar id.');    
    }
    else {         
      // Laddar listan
      List<HeroModel> heroes = await _readHeroList();

      // Tar bort om det finns hjälte med id
      heroes.removeWhere((h) => h.id == hero.id);

      // Lägger till hjälte till lista
      heroes.add(hero);

      // Skriver listan till fil
      bool success = await _writeHeroList(heroes);
      return success; 
    }
  }

  @override
  Future<bool> deleteHero(String heroId) async {

    // Laddar listan
    List<HeroModel> heroes = await _readHeroList();

    // Antal hjältar för borttagningsförsök
    int count = heroes.length;

    // Tar bort om det finns hjälte med id
    heroes.removeWhere((h) => h.id == heroId);
    bool anyDeleted = heroes.length != count;

    if (anyDeleted) {
      // Hjälte har tagits bort, så uppdaterad lista måste skrivas till fil
      bool success = await _writeHeroList(heroes);
      return success; 
    }
    else {
      return false;
    }
  }

  @override
  Future<List<HeroModel>> getHeroes() async {
    List<HeroModel> heroes = await _readHeroList();
    return heroes;
  }

  

  // Funktion för att skriva hjältelista till fil
  Future<bool> _writeHeroList(List<HeroModel> heroes) async {
    try {  
      String jsonString = jsonEncode(heroes.map((hero) => hero.toJson()).toList());     
      return await _fileService.write(jsonString);  
    } catch (e) {
      print('Fel vid skrivning av hjälte lista: $e');
      return false;
    }
  }

  // Funktion för att läsa hjältelista från fil
  Future<List<HeroModel>> _readHeroList() async {
    try {
      List<HeroModel> heroes = [];

      // Kontrollerar om fil är skapad.
      // Ska inte ge fel om filen inte finns ännu.
      bool fileExists = await _fileService.exists();

      if (fileExists)
      {
        String jsonString = await _fileService.read();  
        List<dynamic> jsonList = jsonDecode(jsonString);  
        heroes = jsonList.map((json) => HeroModel.fromJson(json)).toList();
      }
      return heroes;
    } catch (e) {
      print('Fel vid läsning av hjälte lista: $e');
      return [];
    }
  } 
}