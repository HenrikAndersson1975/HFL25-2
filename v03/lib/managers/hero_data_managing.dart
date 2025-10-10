import '../models/exports_hero_models.dart';

abstract class HeroDataManaging
{
  Future<bool> loadHeroes();
  Future<List<HeroModel>> findHeroesByName(String pattern, bool caseSensitive);
  Future<bool> saveHero(HeroModel hero);
  Future<List<HeroModel>> getHeroes();
}