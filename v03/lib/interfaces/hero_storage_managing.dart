import 'package:v03/models/exports_hero_models.dart';
abstract class HeroStorageManaging {
  Future<void> replaceItemCollection(List<HeroModel> heroes);
  Future<void> addNewItem(HeroModel hero);
  Future<List<HeroModel>> load(); 

  SaveType getSaveType();
}

enum SaveType { addNewItem, replaceItemCollection }