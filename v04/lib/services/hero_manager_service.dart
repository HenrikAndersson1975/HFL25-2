import 'package:get_it/get_it.dart';
import '../interfaces/hero_data_managing.dart';

HeroDataManaging getHeroManager() {
  final getIt = GetIt.instance;

  // Hämta objekt som implementerar HeroDataManaging från get_it
  HeroDataManaging manager = getIt<HeroDataManaging>();
  
  return manager;
}

