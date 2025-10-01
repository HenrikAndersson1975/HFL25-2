import 'dart:io';
import 'package:v02/dialogs/dialogs_helper.dart';


class MenuOption<T> 
{ 
  final String text;  // den text som står vid alternativet i menyn
  final T value; // det värde som returneras när användaren gjort menyval
  MenuOption(this.value, this.text);
}

T dialogMenu<T>(String header, List<MenuOption<T>> menuOptions, String prompt) {

  T? selectedValue;

  clearScreen();

  // kör tills användaren gör ett giltigt val
  while (selectedValue == null) {
 
    // skriver ut rubrik
    print('\n$header');

    // skriver ut menyalternativen 
    for (int i=0; i<menuOptions.length; i++) {
      String optionNumber = (i + 1).toString();  // ordningsnummer i listan, det nummer som användaren ska ange
      String text = menuOptions[i].text;   
      print('$optionNumber. $text');
    }
  
    // frågar användaren efter ett alternativ och försöker översätta input till int
    stdout.write(prompt);
    int? selectedOptionNumber = int.tryParse(stdin.readLineSync() ?? '');

    // kollar om valt nummer är mellan 1 och antal menyalternativ
    if (selectedOptionNumber == null || selectedOptionNumber < 1 || selectedOptionNumber > menuOptions.length) {
      print('\nOgiltigt val, försök igen.\n');
    } else {
      // hämtar motsvarande action från menyalternativen
      int optionIndex = selectedOptionNumber - 1;  
      selectedValue = menuOptions[optionIndex].value;  
    }
  }

  // giltigt alternativ har valts, returnerar action
  return selectedValue;
}