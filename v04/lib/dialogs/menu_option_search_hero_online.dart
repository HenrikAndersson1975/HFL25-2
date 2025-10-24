//import 'dart:io';
//import 'dart:convert';
import 'package:v04/dialogs/dialog_enter_hero_name.dart';
import 'package:v04/dialogs/dialog_menu.dart';
import 'package:v04/managers/hero_network_manager.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/services/singletons_service.dart';
import 'dialogs_helper.dart';
//import 'package:v04/services/singletons_service.dart';
//import 'package:v04/interfaces/hero_data_managing.dart';


Future<void> menuOptionSearchHeroOnline() async {

  bool isRunning = true;

  while(isRunning) {
   
    clearScreen();
    print('--- Sök hjälte ---');

    String? partOfHeroName = dialogEnterHeroName();
 
    if (partOfHeroName == null || partOfHeroName.isEmpty) {
      print('Inget namn angivet.');    
    }
    else {    
      List<HeroModel> matchingHeroes = await _getSearchResult(partOfHeroName);
      _showSearchResult(partOfHeroName, matchingHeroes);

      // fråga vad man vill göra med resultatet
      // fråga om man vill spara hjältarna till lista

      if (matchingHeroes.isNotEmpty) 
      {
        
        int menuChoice = dialogMenu<int>(
          '\nHur vill du hantera sökresultatet?',
          [
            MenuOption(1, 'Spara alla hjältar till lokal lagring'),
            MenuOption(2, 'Välj vilka hjältar som ska sparas till lokal lagring'),
            MenuOption(3, 'Gör ingenting'),        
          ],
          'Välj ett alternativ: ',
        );

        switch (menuChoice) {
          case 1: 
            _saveHeroes(matchingHeroes);
            break;
          case 2: 
            _saveSelectedHeroes(matchingHeroes);
            break;
          case 3: 

            break;
        }
      }


    }

    //Frågar användaren om den vill göra en ny sökning eller avsluta
    isRunning = acceptOrDecline('\nVill du göra en ny sökning? (j/n) ', 'j', 'n');
  }

}


void _saveHeroes(List<HeroModel> heroes) {
  print('.... detta ska implementeras... alla hjälar ska sparas');
}
void _saveSelectedHeroes(List<HeroModel> heroes) {
  print('.... detta ska implementeras... ska välja vilka som ska sparas');
}


Future<List<HeroModel>> _getSearchResult(String partOfHeroName) async {

    HeroNetworkManager manager = getHeroNetworkManager();

    print('Hämtar hjältar från server...');
    var (success, matchingHeroes) = await manager.findHeroesByName(partOfHeroName);

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