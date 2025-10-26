import 'package:v04/models/exports_hero_models.dart';
abstract class HeroStorageManaging {
  Future<bool> deleteHero(String heroId);
  Future<bool> upsertHero(HeroModel hero);
  Future<bool> upsertHeroes(List<HeroModel> heroes);
  Future<List<HeroModel>> getHeroes(); 
}

