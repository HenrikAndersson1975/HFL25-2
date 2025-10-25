import 'dart:io';

class MenuOption<T> 
{ 
  final String text;  // den text som står vid alternativet i menyn
  final T value; // det värde som returneras när användaren gjort menyval
  String? selectValue;  // det som ska anges för att detta alternativ ska returneras
  MenuOption(this.value, this.text, {this.selectValue});
}

T dialogMenu<T>(String header, List<MenuOption<T>> menuOptions, String prompt) {

  T? selectedValue;

  // Säkerställer att alla MenuOptions har ett selectValue 
  // ... borde egentligen kontrollera att inte flera alternativ har samma ...
  for (int i=0; i<menuOptions.length; i++) {   
    if (menuOptions[i].selectValue == null || menuOptions[i].selectValue!.isEmpty) {
      String optionNumber = (i + 1).toString();  // ordningsnummer i listan   
      menuOptions[i].selectValue = optionNumber;
    }
  }

  // Kör tills användaren gör ett giltigt val
  while (selectedValue == null) {
 
    // Skriver ut rubrik
    if (header.isNotEmpty) {
      print(header);
    }

    // Skriver ut menyalternativen 
    for (int i=0; i<menuOptions.length; i++) {     
      String text = menuOptions[i].text;         
      String selectValue = menuOptions[i].selectValue!;
      print('$selectValue. $text');
    }
  
    // Frågar användaren efter ett alternativ 
    stdout.write(prompt);
    String selectedOptionValue = stdin.readLineSync()?.trim() ?? '';

    // Kollar om angivet värde matchar ett menyalternativ     
    MenuOption? selectedOption;
    if (selectedOptionValue.isNotEmpty) {
      try {
        selectedOption = menuOptions.firstWhere((o) => o.selectValue == selectedOptionValue);
      }
      catch (e) {
        selectedOption=null;
      }
    } 
    
    if (selectedOption == null) {
      print('\nOgiltigt val, försök igen.\n');
    } else {
      // Hämtar motsvarande värde från menyalternativen   
      selectedValue = selectedOption.value;  
    }
  }

  // Giltigt alternativ har valts, returnerar vald menuOptions value
  return selectedValue;
}