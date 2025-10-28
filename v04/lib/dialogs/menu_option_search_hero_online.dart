
import 'dart:io';
import 'dialog_enter_hero_name.dart';
import 'package:v04/interfaces/hero_data_managing.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/services/singletons_service.dart';
import 'dialogs_helper.dart';
import 'package:v04/interfaces/hero_network_managing.dart';
import 'dialog_onoff.dart';

Future<bool> menuOptionSearchHeroOnline() async {

  int savedCount = 0;

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
      List<HeroModel> heroes = [];

      // Kommunicerar med server
      try {
        heroes = await _getSearchResult(partOfHeroName);       
      }

      // Om fel i kommunikation, visas meddelande
      catch (e) {
        print(e);
        waitForEnter('Tryck ENTER för att fortsätta');
      }


      // Frågar användare vilka hjätar som ska sparas
      if (heroes.isNotEmpty) 
      {
        List<DialogOnOffMenuOption<HeroModel>> options = [];
        for (int i=0; i<heroes.length; i++) {
          DialogOnOffMenuOption<HeroModel> option = DialogOnOffMenuOption(heroes[i], heroes[i].name ?? "", true, DialogOnOffMenuAction.toggle);
          options.add(option);
        }
        options.add(DialogOnOffMenuOption(HeroModel(), "* Växla alla (Ja <-> Nej)", null, DialogOnOffMenuAction.toggleAll, selectValue: 'v'));
        options.add(DialogOnOffMenuOption(HeroModel(), "= Spara valda", null, DialogOnOffMenuAction.returnSelection, selectValue: 's'));
        options.add(DialogOnOffMenuOption(HeroModel(), "= Avbryt", null, DialogOnOffMenuAction.cancel, selectValue: 'x'));

        List<HeroModel>? selectedHeroes = dialogOnOff("Ange vilka som du vill spara (Ja=Spara)", options, "Ja", "Nej", "Välj alternativ: ");

        if (selectedHeroes != null && selectedHeroes.isNotEmpty)
        {
           savedCount += await _saveHeroes(selectedHeroes);
           waitForEnter('\n\nTryck ENTER för att gå tillbaka till listan.');
        }
      }
    }

    //Frågar användaren om den vill göra en ny sökning eller avsluta
    isRunning = false; //acceptOrDecline('\nVill du göra en ny sökning? (j/n) ', 'j', 'n');
  }
     
  // true om någon hjälte har tagits bort
  return savedCount>0;
}


// Sparar hjältar och visar vilka som sparades
Future<int> _saveHeroes(List<HeroModel> heroes) async {
  
  int savedCount = 0;

  clearScreen();

  stdout.write('Sparar ${heroes.length==1?'hjälte':'hjältar'}...');

  HeroDataManaging manager = getManager<HeroDataManaging>();

  // Försöker spara hjältarna en och en, visar om det gick bra eller dåligt
  for (int i=0; i < heroes.length; i++) {
    HeroModel hero = heroes[i];

    stdout.write('\nSparar ${hero.name}...');
    try {
      bool success = await manager.addHero(hero);
      if (success) { stdout.write('OK'); savedCount++; }
    }
    catch (e) {
      stdout.write(e);
    }
  }

  print('');  

  return savedCount;
}


// Hämtar hjältar från server
Future<List<HeroModel>> _getSearchResult(String partOfHeroName) async {

    HeroNetworkManaging manager = getManager<HeroNetworkManaging>();

    print('\nHämtar hjältar från server...');
    var (success, matchingHeroes) = await manager.findHeroesByName(partOfHeroName);

    return matchingHeroes;
}

