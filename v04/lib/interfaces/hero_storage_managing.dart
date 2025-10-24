import 'package:v04/models/exports_hero_models.dart';
abstract class HeroStorageManaging {
  Future<void> deleteHero(String heroId);
  Future<void> upsertHero(HeroModel hero);
  Future<List<HeroModel>> getHeroes(); 
}

