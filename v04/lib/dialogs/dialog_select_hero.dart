import 'package:v04/dialogs/dialog_menu.dart';
import 'package:v04/models/exports_hero_models.dart';

HeroModel? dialogSelectHero(String header, List<HeroModel> heroes, String prompt) {

  List<MenuOption<HeroModel?>> menuOptions = [];  
  for (int i=0; i<heroes.length; i++) {
    HeroModel hero = heroes[i];
    menuOptions.add(MenuOption(hero, hero.name ?? 'Namn saknas, id:${hero.id}'));
  }
  HeroModel emptyHero = HeroModel();
  menuOptions.add(MenuOption(emptyHero, 'Avbryt', selectValue: 'x'));
  HeroModel? selectedHero = dialogMenu(header, menuOptions, prompt);
  return selectedHero == emptyHero ? null : selectedHero;
}