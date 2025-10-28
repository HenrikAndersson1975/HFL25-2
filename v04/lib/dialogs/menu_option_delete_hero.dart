import 'dart:io';
import 'package:v04/dialogs/exports_dialogs.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/interfaces/hero_data_managing.dart';
import 'package:v04/services/singletons_service.dart';

Future<bool> menuOptionDeleteHero(List<HeroModel> heroes) async {

  int deletedCount = 0;

  List<DialogOnOffMenuOption<HeroModel>> options = [];
  for (int i=0; i<heroes.length; i++) {
    DialogOnOffMenuOption<HeroModel> option = DialogOnOffMenuOption(heroes[i], heroes[i].name ?? "", false, DialogOnOffMenuAction.toggle);
    options.add(option);
  }
  options.add(DialogOnOffMenuOption(HeroModel(), "* Växla alla (Ja <-> Nej)", null, DialogOnOffMenuAction.toggleAll, selectValue: 'v'));
  options.add(DialogOnOffMenuOption(HeroModel(), "= Ta bort valda", null, DialogOnOffMenuAction.returnSelection, selectValue: 's'));
  options.add(DialogOnOffMenuOption(HeroModel(), "= Avbryt", null, DialogOnOffMenuAction.cancel, selectValue: 'x'));

  clearScreen();

  print('--- Radera hjälte ---');

  List<HeroModel>? selectedHeroes = dialogOnOff("Ange vilka som du vill ta bort (Ja=ta bort)", options, "Ja", "Nej", "Välj alternativ: ");

  if (selectedHeroes != null && selectedHeroes.isNotEmpty)
  {
      print('');

      HeroDataManaging manager = getManager<HeroDataManaging>();

      for(int i=0; i<selectedHeroes.length; i++) {

        String? id = selectedHeroes[i].id;

        if (id != null) {
          
          String name = selectedHeroes[i].name ?? 'Okänt namn';

          stdout.write('\nTar bort $name...');

          bool deleted = await manager.deleteHero(id);
       
          if (deleted) {
            stdout.write('OK');
            deletedCount++;
          }
        }
      }

      waitForEnter('\n\nTryck ENTER för att gå tillbaka till listan.');
  }
      
  // true om någon hjälte har tagits bort
  return deletedCount>0;
}