
import 'package:v03/models/exports_hero_models.dart';
import 'mocks/mock_hero_data_manager.dart';

Future<void> main() async {
  final manager = MockHeroDataManager();

  print("Alla hjältar:");
  for (var hero in await manager.getHeroes()) {
    print(hero.toDisplayString());
  }

  print("\nSök efter 'Ivan':");
  final results = await manager.findHeroesByName("ivan", false);
  for (var hero in results) {
    print(hero.toDisplayString());
  }

  print("\nLägg till ny hjälte:");
  await manager.saveHero(HeroModel(
    name: "Phantom Blaze",
    powerstats: Powerstats(intelligence: 70),
    biography: Biography(fullName: "Finn Phantom"),
    appearance: Appearance(gender: "man"),
  ));

  for (var hero in await manager.getHeroes()) {
    print(hero.toDisplayString());
  }
}