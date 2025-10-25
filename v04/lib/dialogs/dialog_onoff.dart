import 'package:v04/services/translation_service.dart';

import 'dialogs_helper.dart';
import 'dialog_menu.dart';
import 'dart:math';


// selectedOptions är de texter som nu är valda
// options är de texter som är valbara
// menuOptionExitText är den text som står vid menyalternativ som motsvarar Avbryt
// optionSelectedText är den text som står vid de menyalternativ som är valda
// optionNotSelectedText är den text står vid de menyalternativ som inte är valda
List<String> dialogOnOff(String header, List<String> selectedOptions, List<String> options, String menuOptionExitText, String optionSelectedText, String optionNotSelectedText, String prompt) {

  // arbetar med kopia av värden
  List<String> list = [];
  list.addAll(selectedOptions);

  bool isRunning = true;

  while(isRunning) {

    clearScreen();

    // Lägger till menyalternativ och anger om de är VALDA eller INTE VALDA
    List<MenuOption<String>> menuOptions = [];
    for(int i=0; i<options.length; i++) {
      String value = options[i];
      String translation = translateToSwedish(value);
      menuOptions.add(MenuOption(value, '${list.contains(value) ? optionSelectedText : optionNotSelectedText} $translation'));
    }

    // Lägger till avslutande menyalternativ för att avbryta
    int l = max(optionSelectedText.length,optionNotSelectedText.length);
    String indentedString = ' ' * (l+1) + menuOptionExitText;
    menuOptions.add(MenuOption('xxxxexitxxxx', indentedString));

    // Visa meny 
    String selectedOption = dialogMenu(header, menuOptions, prompt);

    // Hantera val
    if (options.contains(selectedOption)) {
      _swap(list, selectedOption);
    }
    else {
      isRunning = false;
    }
  }
  
  // Returnerar valda texter
  return list;
}


// Om element finns i lista, ta bort det, annars lägg till det
void _swap(List<String> list, String element) {
  if (list.contains(element)) {
    list.remove(element);
  }
  else {
    list.add(element);
  }
}