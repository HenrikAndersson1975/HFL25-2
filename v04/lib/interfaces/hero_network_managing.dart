import 'package:v04/models/hero_model.dart';
abstract class HeroNetworkManaging 
{
  Future<List<HeroModel>?> getHeroesByName(String searchPattern);
}