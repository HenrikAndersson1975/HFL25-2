import 'package:v03/interfaces/hero_storage_managing.dart';
import 'package:v03/models/hero_model.dart';

// förberett för att den skulle använda databas, t ex objectbox, men vill inte röra till det i nuläget
// 

class HeroDatabaseManager implements HeroStorageManaging
{
  //static final HeroDatabaseManager _instance = HeroDatabaseManager._privateConstructor();

  //HeroDatabaseManager._privateConstructor();

  

  @override
  Future<void> addNewItem(HeroModel hero) {
	  throw UnimplementedError("Används inte i nuläget, vi läser och skriver från fil bara.");
  }

  @override
  SaveType getSaveType() {
    return SaveType.addNewItem; // visar att detta storage kan spara ett element åt gången
  }

  @override
  Future<List<HeroModel>> load() async { 
	  throw UnimplementedError("Används inte i nuläget, vi läser och skriver från fil bara.");
  }

  @override
  Future<void> replaceItemCollection(List<HeroModel> heroes) {
	  throw Exception("Detta storage ska inte utföra denna operation.");
  }
}