import 'package:v03/models/exports_hero_models.dart';
abstract class HeroStorageManaging {
  Future<void> save(List<HeroModel> heroes);
  Future<List<HeroModel>> load(); 
}