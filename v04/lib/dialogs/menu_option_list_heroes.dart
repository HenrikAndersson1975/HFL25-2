import 'dialogs_helper.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/services/singletons_service.dart';
import 'package:v04/interfaces/hero_data_managing.dart';
import 'dialog_menu.dart';




/// Visar alla hjältar i listan, sorterade efter styrka (starkaste först)
Future<void> menuOptionListHeroes() async {

  print('Hämtar lista med hjältar...');
  
  // Hämtar listan
  HeroDataManaging manager = getHeroDataManager();
  List<HeroModel> heroes = await manager.getHeroes();  

  // Definierar default-värden för sortering och filtering
  int defaultSorting = _Sorting.none; 
  List<String> defaultAlignmentFilter = ["good", "neutral", "bad"];

  // Sätter gällande inställning för sortering och filtrering
  int sorting = defaultSorting;
  List<String> alignmentFilter = []..addAll(defaultAlignmentFilter);
  
  bool isRunning = true;
  
  while (isRunning)
  {
    // Tar fram lista enligt gällande inställningar
    List<HeroModel> filteredAndSortedHeroes = _filterAndSort(heroes, sorting, alignmentFilter);

    clearScreen();

    print('--- Lista över hjältar ---');

    

    // Skriver ut listan
    _printHeroList(filteredAndSortedHeroes);

    //
    print('Listan innehåller ${heroes.length} ${heroes.length == 1 ? 'hjälte' : 'hjältar'}.');

    // Skriver ut gällande inställningar för listan
    _printCurrentFilter(alignmentFilter);
    _printCurrentSorting(sorting);

    // Visa meny 
    _MenuAction action = dialogMenu('', 
      [
        MenuOption(_MenuAction.editSorting, 'Ändra sortering'),
        MenuOption(_MenuAction.editFilter, 'Ändra filtrering'),
        MenuOption(_MenuAction.reset, 'Återställ sortering och filtrering'),
        MenuOption(_MenuAction.exit, 'Tillbaka')
      ], 
      'Välj ett alternativ: ');

    switch(action) {
      case _MenuAction.editSorting: 
        print('todo'); waitForEnter('tryck enter');  // TODO
        break;
      case _MenuAction.editFilter: 
        print('todo'); waitForEnter('tryck enter');  // TODO
        break;
      case _MenuAction.reset: 
        sorting = defaultSorting;
        alignmentFilter = []..addAll(defaultAlignmentFilter);
        break;
      case _MenuAction.exit:
        isRunning = false;
        break;
    }
  }

}


/// Alternativ i meny
enum _MenuAction {
  editSorting, editFilter, reset, exit
}


class _Sorting {
  static const int none = 0;
  static const int name = 1; 
  static const int strength = 2;
}



List<HeroModel> _filterAndSort(List<HeroModel> heroes, int sorting, List<String> alignmentFilter) {

  // gör kopia av lista
  List<HeroModel> list = [];
  list.addAll(heroes);


  //_filterByAlignment(heroes, alignmentFilter);

  return list;
}

void _printHeroList(List<HeroModel> heroes) {
  for (int i=0; i<heroes.length; i++) {
    String? s = heroes[i].toDisplayString(number: i+1);
    print(s);
  }
}
void _printCurrentSorting(int sorting) {
  print('todo här ska inställning för sortering visas');
}
void _printCurrentFilter(List<String> alignmentFilter) {
  print('todo här ska inställning för filter visas');
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


// lägg till sortering
// lägg till filter
// ta bort


// lägg till submeny
//  visa alla
//  lista efter styrka
//  lista efter namn
//  lista goda
//  lista onda
//  lista neutrala

// .... 
//  