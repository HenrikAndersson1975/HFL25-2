import 'package:v03/interfaces/hero_storage_managing.dart';
import 'package:v03/models/exports_hero_models.dart';
import 'dart:io';
import 'dart:convert';

class HeroFileManager implements HeroStorageManaging
{
  // Skapar instans, som sedan kommer att returneras varje gång HeroDataManager() anropas.
  static final HeroFileManager _instance = HeroFileManager._privateConstructor();

  // Privat konstruktor
  HeroFileManager._privateConstructor();

  String? _filePath;

  // Factory-konstruktor som alltid returnerar samma instans
  factory HeroFileManager(String filePath) {
    _instance._filePath = filePath;
    return _instance;
  }

  @override
  SaveType getSaveType() {
   return SaveType.replaceItemCollection; // visar att detta storage inte kan ta emot ett element, utan vill ersätta hela listan
  }

  @override
  Future<void> addNewItem(HeroModel hero) async {
    throw Exception("Detta storage kan inte ta emot element, utan vill ersätta hela listan.");
  }

  @override
  Future<void> replaceItemCollection(List<HeroModel> heroes) async {
    final file = File(_filePath ?? '');  
    final jsonString = jsonEncode(heroes.map((hero) => hero.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  @override
  Future<List<HeroModel>> load() async {
    final file = File(_filePath ?? '');
    if (!await file.exists()) {
      return [];
    }
    final jsonString = await file.readAsString();  
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => HeroModel.fromJson(json)).toList();
  }
}