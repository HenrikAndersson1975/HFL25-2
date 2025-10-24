import 'package:get_it/get_it.dart';
import 'package:v04/managers/hero_file_manager.dart';
import '../interfaces/hero_data_managing.dart';
import 'package:v04/managers/hero_network_manager.dart';
import 'package:v04/interfaces/hero_storage_managing.dart';


HeroDataManaging getHeroDataManager() {
  final getIt = GetIt.instance;
  HeroDataManaging manager = getIt<HeroDataManaging>();
  return manager;
}
void registerHeroDataManager(HeroDataManaging instance) {
  final getIt = GetIt.instance;
  getIt.registerSingleton<HeroDataManaging>(instance);  
}

HeroStorageManaging getHeroStorageManager() {
  final getIt = GetIt.instance;
  HeroStorageManaging manager = getIt<HeroStorageManaging>();
  return manager;
}
void registerHeroStorageManager(HeroFileManager instance)  {
  final getIt = GetIt.instance;
  getIt.registerSingleton<HeroFileManager>(instance);  
}

HeroNetworkManager getHeroNetworkManager() {
  final getIt = GetIt.instance;
  HeroNetworkManager manager = getIt<HeroNetworkManager>();
  return manager;
}
void registerHeroNetworkManager(HeroNetworkManager instance)  {
  final getIt = GetIt.instance;
  getIt.registerSingleton<HeroNetworkManager>(instance);  
}