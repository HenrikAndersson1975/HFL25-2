import 'package:v04/models/hero_model.dart';
abstract class HeroNetworkManaging 
{
  Future<(bool success,List<HeroModel> heroes)> findHeroesByName(String searchPattern);
}