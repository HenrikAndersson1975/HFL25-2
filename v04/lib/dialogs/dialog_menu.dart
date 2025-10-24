import 'dart:io';
import 'package:v04/dialogs/dialogs_helper.dart';


class MenuOption<T> 
{ 
  final String text;  // den text som står vid alternativet i menyn
  final T value; // det värde som returneras när användaren gjort menyval
  MenuOption(this.value, this.text);
}

T dialogMenu<T>(String header, List<MenuOption<T>> menuOptions, String prompt) {

  T? selectedValue;

  

  // Kör tills användaren gör ett giltigt val
  while (selectedValue == null) {
 
    // Skriver ut rubrik
    print(header);

    // Skriver ut menyalternativen 
    for (int i=0; i<menuOptions.length; i++) {
      String optionNumber = (i + 1).toString();  // ordningsnummer i listan, det nummer som användaren ska ange
      String text = menuOptions[i].text;   
      print('$optionNumber. $text');
    }
  
    // Frågar användaren efter ett alternativ och försöker översätta input till int
    stdout.write(prompt);
    int? selectedOptionNumber = int.tryParse(stdin.readLineSync() ?? '');

    // Kollar om valt nummer är mellan 1 och antal menyalternativ
    if (selectedOptionNumber == null || selectedOptionNumber < 1 || selectedOptionNumber > menuOptions.length) {
      print('\nOgiltigt val, försök igen.\n');
    } else {
      // Hämtar motsvarande värde från menyalternativen
      int optionIndex = selectedOptionNumber - 1;  
      selectedValue = menuOptions[optionIndex].value;  
    }
  }

  // Giltigt alternativ har valts, returnerar vald menuOptions value
  return selectedValue;
}