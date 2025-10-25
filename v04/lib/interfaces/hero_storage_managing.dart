import 'package:v04/models/exports_hero_models.dart';
abstract class HeroStorageManaging {
  Future<void> deleteHero(String heroId);
  Future<void> upsertHero(HeroModel hero);
  Future<void> upsertHeroes(List<HeroModel> heroes);
  Future<List<HeroModel>> getHeroes(); 
}

