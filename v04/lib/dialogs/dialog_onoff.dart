import 'package:v04/services/translation_service.dart';
import 'dialogs_helper.dart';
import 'dialog_menu.dart';
import 'dart:math';
import 'dart:io';


enum DialogOnOffMenuAction {
  toggle, toggleAll, returnSelection, cancel
}

class DialogOnOffMenuOption<T> extends MenuOption<T> {
  bool? isSelected;
  DialogOnOffMenuAction action;
  String? displayText;
  DialogOnOffMenuOption(super.value, super.text, this.isSelected, this.action, {super.selectValue}); 
}
 
List<T>? dialogOnOff<T>(String header, List<DialogOnOffMenuOption<T>> options, String optionSelectedText, String optionNotSelectedText, String prompt) {

  List<T>? selected;

  bool isRunning = true;

  while(isRunning) {

    clearScreen();

    // Sätt text 
    for (int i=0; i<options.length; i++) {
      options[i].displayText = _getDisplayText(options[i], optionSelectedText, optionNotSelectedText);
    }

    // Vänta på val från användare
    DialogOnOffMenuOption<T> selectedOption = _dialogMenu<T>(header, options, prompt);

    switch (selectedOption.action) {
      case DialogOnOffMenuAction.toggle:
        _toggle(selectedOption);
        break;
      case DialogOnOffMenuAction.toggleAll:
        for (int i=0; i<options.length; i++) {
          _toggle(options[i]);
        }
        break;
      case DialogOnOffMenuAction.returnSelection:
        selected = _getSelectedValues<T>(options);
        isRunning = false;
        break;
      case DialogOnOffMenuAction.cancel:     
        isRunning = false;
        break;
    }
  }
  
  return selected;
}


String _getDisplayText(DialogOnOffMenuOption option, String optionSelectedText, String optionNotSelectedText) {

  String translation = translateToSwedish(option.text);
  
  String displayText;
  if (option.action == DialogOnOffMenuAction.toggle) {
    String statusText = (option.isSelected ?? false) ? optionSelectedText : optionNotSelectedText;

    int l = max(optionSelectedText.length, optionNotSelectedText.length) - statusText.length;
    statusText = statusText.padRight(statusText.length + l);

    displayText = '$statusText $translation';
  }
  else {
    displayText = translation;
  }
  
  return displayText;
}

List<T> _getSelectedValues<T>(List<DialogOnOffMenuOption<T>> menuOptions) {
  List<T> list = [];
  for (int i=0; i<menuOptions.length; i++) {
    
    if (menuOptions[i].isSelected ?? false) {    
      list.add(menuOptions[i].value);
    }
  }
  return list;
}

void _toggle(DialogOnOffMenuOption menuOption) {
  if (menuOption.action == DialogOnOffMenuAction.toggle) {
    menuOption.isSelected = !(menuOption.isSelected ?? true);   
  }
}

DialogOnOffMenuOption<T> _dialogMenu<T>(String header, List<DialogOnOffMenuOption<T>> menuOptions, String prompt) {

  DialogOnOffMenuOption<T>? selectedOption;

  for (int i=0; i<menuOptions.length; i++) {   
    if (menuOptions[i].selectValue == null || menuOptions[i].selectValue!.isEmpty) {
      String optionNumber = (i + 1).toString();  // ordningsnummer i listan   
      menuOptions[i].selectValue = optionNumber;
    }
  }

  // Kör tills användaren gör ett giltigt val
  while (selectedOption == null) {
 
    // Skriver ut rubrik
    if (header.isNotEmpty) {
      print(header);
    }

    // Skriver ut menyalternativen 
    for (int i=0; i<menuOptions.length; i++) {     
      String text = menuOptions[i].displayText ?? "";         
      String selectValue = menuOptions[i].selectValue!;
      print('$selectValue. $text');
    }
  
    // Frågar användaren efter ett alternativ 
    stdout.write(prompt);
    String selectedOptionValue = stdin.readLineSync()?.trim() ?? '';

    // Kollar om angivet värde matchar ett menyalternativ       
    if (selectedOptionValue.isNotEmpty) {
      try {
        selectedOption = menuOptions.firstWhere((o) => o.selectValue == selectedOptionValue);
      }
      catch (e) {
        selectedOption = null;
      }
    } 
    
    if (selectedOption == null) {
      print('\nOgiltigt val, försök igen.\n');
    } 
  }

  // Giltigt alternativ har valts, returnerar vald menuOptions value
  return selectedOption;
}