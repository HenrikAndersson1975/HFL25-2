import 'exports_menu_options.dart';
import 'menu_option_delete_hero.dart';

import 'dialog_onoff.dart';
import 'dialogs_helper.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/services/singletons_service.dart';
import 'package:v04/interfaces/hero_data_managing.dart';
import 'dialog_menu.dart';




/// Visar alla hjältar i listan, sorterade efter styrka (starkaste först)
Future<void> menuOptionListHeroes() async {

  bool reloadHeroes = true;

  List<HeroModel> heroes = [];  

  // Definierar default-värden för sortering och filtering
  List<String> defaultSorting = []; 
  List<String> defaultAlignmentFilter = ["good", "neutral", "bad"];

  // Sätter gällande inställning för sortering och filtrering
  List<String> sorting = []..addAll(defaultSorting);
  List<String> alignmentFilter = []..addAll(defaultAlignmentFilter);
  
  bool isRunning = true;
  
  while (isRunning)
  {
    if (reloadHeroes) { 
      clearScreen();
      print('Hämtar lista med hjältar...'); 
      HeroDataManaging manager = getHeroDataManager();    
      heroes = await manager.getHeroes();   
      reloadHeroes = false;
    }

    // Tar fram lista enligt gällande inställningar
    List<HeroModel> filteredAndSortedHeroes = _filterAndSort(heroes, sorting, alignmentFilter);

    clearScreen();
    print('--- Lista över hjältar ---');

    // Skriver ut listan
    _printHeroList(filteredAndSortedHeroes);

    //
    print('\nListan innehåller ${heroes.length} ${heroes.length == 1 ? 'hjälte' : 'hjältar'}, varav ${filteredAndSortedHeroes.length} ${filteredAndSortedHeroes.length == 1 ? 'hjälte' : 'hjältar'} visas med nuvarande filtrering');

    // Skriver ut gällande inställningar för listan
    _printCurrentFilter(alignmentFilter);
    _printCurrentSorting(sorting);

    // Visa meny 
    _MenuAction action = dialogMenu('', 
      [
        MenuOption(_MenuAction.editSorting, 'Ändra sortering'),
        MenuOption(_MenuAction.editFilter, 'Ändra filtrering'),
        MenuOption(_MenuAction.reset, 'Återställ sortering och filtrering'),      
        MenuOption(_MenuAction.addHero, 'Lägg till hjälte'),
        MenuOption(_MenuAction.deleteHero, 'Ta bort hjälte'),
        MenuOption(_MenuAction.exit, 'Tillbaka')
      ], 
      'Välj ett alternativ: ');

    switch(action) {
      case _MenuAction.editSorting:         
        sorting = dialogOnOff('Inställning för sortering',  sorting, ['name','strength'], 'Visa lista', 'PÅ', 'AV', 'Välj ett alternativ: ');
        break;
      case _MenuAction.editFilter:        
        alignmentFilter = dialogOnOff('Inställning för filtrering', alignmentFilter, ['good','neutral','bad'], 'Visa lista', 'VISA', 'DÖLJ', 'Välj ett alternativ: ');   
        break;
      case _MenuAction.reset: 
        sorting.clear(); sorting.addAll(defaultSorting);
        alignmentFilter.clear(); alignmentFilter.addAll(defaultAlignmentFilter);
        break;
      case _MenuAction.addHero:
        bool newHeroCreated = await menuOptionCreateHero();       
        if (newHeroCreated) { reloadHeroes = true; }
        break;
      case _MenuAction.deleteHero:
        bool heroDeleted = await menuOptionDeleteHero(filteredAndSortedHeroes);
        if (heroDeleted) { reloadHeroes = true; }
        break;
      case _MenuAction.exit:
        isRunning = false;
        break;    
    }
  }
}








enum _MenuAction { editSorting, editFilter, reset, addHero, deleteHero, exit }

List<HeroModel> _filterAndSort(List<HeroModel> heroes, List<String> sorting, List<String> alignmentFilter) {

  // gör kopia av lista
  List<HeroModel> list = [];
  list.addAll(heroes);

  // filtrera
  list = _filterByAlignment(list, alignmentFilter);

  // sortera
  for (int i=0; i<sorting.length; i++) {
    String sortType = sorting[i];
    switch (sortType) {
      case 'name': _sortByName(list); break;
      case 'strength': _sortByStrength(list); break;
    }
  }

  return list;
}

void _printHeroList(List<HeroModel> heroes) {
  for (int i=0; i<heroes.length; i++) {
    String? s = heroes[i].toDisplayString(number: i+1);
    print(s);
  }
}
void _printCurrentSorting(List<String> sorting) {
  String settings = sorting.join(', ');   // översätt???
  if (settings.isEmpty) settings = '-';
  print('  Sortering: $settings');
}
void _printCurrentFilter(List<String> alignmentFilter) {
  String settings = alignmentFilter.join(', ');  // översätt???
  if (settings.isEmpty) settings = '-';
  print('  Filter, moralisk inriktning: $settings');
}

void _sortByStrength(List<HeroModel> heroes) {
  heroes.sort((a, b) {
      int strengthA = a.powerstats?.strength ?? 0;
      int strengthB = b.powerstats?.strength ?? 0;
      return strengthB.compareTo(strengthA); // Sortera i fallande ordning
    });
}
void _sortByName(List<HeroModel> heroes) {
  heroes.sort((a, b) {
      String nameA = a.name ?? '';
      String nameB = b.name ?? '';
      return nameA.compareTo(nameB); 
    });
}
List<HeroModel> _filterByAlignment(List<HeroModel> heroes, List<String> selectedAlignmentValues) {
  return heroes.where((h) => selectedAlignmentValues.contains(h.biography?.alignment)).toList();
}
