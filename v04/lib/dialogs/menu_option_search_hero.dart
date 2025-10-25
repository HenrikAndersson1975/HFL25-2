import 'package:v04/models/exports_hero_models.dart';
import 'dialogs_helper.dart';
import 'package:v04/services/singletons_service.dart';
import 'package:v04/interfaces/hero_data_managing.dart';
import 'package:v04/dialogs/dialog_enter_hero_name.dart';

/// Söker hjälte i lokal lista
Future<void> menuOptionSearchHero() async {

  bool isRunning = true;

  while(isRunning) {
   
    clearScreen();
    print('--- Sök hjälte ---');

    // Användare anger ett namn
    String? partOfHeroName = dialogEnterHeroName();

    if (partOfHeroName == null || partOfHeroName.isEmpty) {
      print('Inget namn angivet.');    
    }
    else {    
      List<HeroModel> matchingHeroes = await _getSearchResult(partOfHeroName);
      _showSearchResult(partOfHeroName, matchingHeroes);
    }

    // Frågar användaren om den vill göra en ny sökning eller avsluta
    isRunning = acceptOrDecline('\nVill du göra en ny sökning? (j/n) ', 'j', 'n');
  }
}


Future<List<HeroModel>> _getSearchResult(String partOfHeroName) async {
    HeroDataManaging manager = getHeroDataManager();   
    List<HeroModel> matchingHeroes = await manager.findHeroesByName(partOfHeroName, false);
    return matchingHeroes;
}

void _showSearchResult(String partOfHeroName, List<HeroModel> matchingHeroes) {
    clearScreen();
    print('--- Sök hjälte ---');

    // Visar resultatet av sökningen
    if (matchingHeroes.isEmpty) {
      print('Ingen hjälte hittades med namn som innehåller "$partOfHeroName".');
    } else {
      print('Hittade ${matchingHeroes.length} ${matchingHeroes.length == 1 ? 'hjälte' : 'hjältar'} som matchar "$partOfHeroName".');   
      for (int i=0; i<matchingHeroes.length; i++) {        
        String? s = matchingHeroes[i].toDisplayString();
        print(s);
      }   
    }
}