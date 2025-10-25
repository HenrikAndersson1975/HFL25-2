import 'package:v04/models/exports_hero_models.dart';

abstract class HeroDataManaging
{  
  Future<List<HeroModel>> findHeroesByName(String pattern, bool caseSensitive);
  Future<bool> addHero(HeroModel hero);
  Future<bool> deleteHero(String id);
  Future<List<HeroModel>> getHeroes();
}