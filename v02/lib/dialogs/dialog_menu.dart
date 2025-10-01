import 'dart:io';
import 'package:v02/dialogs/dialogs_helper.dart';

import '../enumerations.dart';

class MenuOption 
{ 
  final String text;
  final Action action;
  MenuOption(this.action, this.text);
}

Action dialogMenu(String header, List<MenuOption> menuOptions, String prompt) {

  Action? selectedAction;

  clearScreen();

  // kör tills användaren gör ett giltigt val
  while (selectedAction == null) {
 
    // skriver ut rubrik
    print('\n$header');

    // skriver ut menyalternativen 
    for (int i=0; i<menuOptions.length; i++) {
      String optionNumber = (i + 1).toString();  // ordningsnummer i listan, det nummer som användaren ska ange
      String text = menuOptions[i].text;   
      print('$optionNumber. $text');
    }
  
    // frågar användaren efter val och försöker översätta input till int
    stdout.write(prompt);
    int? selectedOptionNumber = int.tryParse(stdin.readLineSync() ?? '');

    // kollar om valt nummer är mellan 1 och antal menyalternativ
    if (selectedOptionNumber == null || selectedOptionNumber < 1 || selectedOptionNumber > menuOptions.length) {
      print('\nOgiltigt val, försök igen.\n');
    } else {
      // hämtar motsvarande action från menyalternativen
      int optionIndex = selectedOptionNumber - 1;  
      selectedAction = menuOptions[optionIndex].action;  
    }
  }

  // giltigt alternativ har valts, returnerar action
  return selectedAction;
}