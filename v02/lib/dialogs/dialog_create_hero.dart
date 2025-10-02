import 'dart:io';
import 'dialogs_helper.dart';
import 'package:v02/hero.dart';



Map<String, dynamic>? dialogCreateHero() {

  clearScreen();

  print('--- Skapa hjälte ---');
  print('Ange egenskaper för hjälten.');
  String name = _getValidStringProperty('Namn', "name");
  int strength = _getValidIntProperty('Styrka', "strength");
  String gender = _getValidStringProperty('Kön', "gender");
  String alignment = _getValidStringProperty('Moralisk inriktning', "alignment");

  Map<String, dynamic> newHero = createHero(name, strength, gender, alignment);

  return newHero;
}



String _getValidStringProperty(String prompt, String propertyKey) {
  
  // Tar fram giltiga värden för egenskapen
  List<String>? acceptedPropertyValues;
  {
    Map<String, dynamic> validProperties = getValidProperties();

    // förutsätter att giltiga strängvärden lagras i en lista
    acceptedPropertyValues = getPropertyValue(validProperties, propertyKey);
  }

  // Sätter det till null om inga alternativ finns/hittas
  if (acceptedPropertyValues == null || acceptedPropertyValues.isEmpty) {
      acceptedPropertyValues = null;
  }

  // Lista med valbara alternativ
  String promptExtension = "";
  {
    if (acceptedPropertyValues != null)  {
        promptExtension += " (";
        for (int i=0; i<acceptedPropertyValues.length; i++) {
          promptExtension += (i>0? "/":"") + acceptedPropertyValues[i];
        }
        promptExtension += ")";
    }
  }

  // Lägg till alternativ till prompt så att användaren ser vad som är giltigt
  prompt += "$promptExtension: ";


  String? selectedValue;
  {
    // Frågar efter värde tills användaren angvit giltigt värde
    while (selectedValue == null)
    {
      selectedValue = _getValueFromUser(prompt);
      selectedValue = selectedValue?.trim();

      if (selectedValue != null) {          
          if (acceptedPropertyValues != null && !acceptedPropertyValues.contains(selectedValue)) {
            selectedValue = null;  // Om angiven sträng inte är ett giltigt värde, sätt till null
          } 
      }

      // Om värde är null här, är det ogiltigt
      if (selectedValue == null) {
        print('Ogiltigt värde.');
      }
    }
  }
  return selectedValue;
}


int _getValidIntProperty(String prompt, String propertyKey) {
   
  // Letar upp min- och max-värde för egenskapen
  int? min;
  int? max;
  {
    Map<String, dynamic> validProperties = getValidProperties();

    // förutsätter att giltiga värden lagras i ett intervall som kan ha min och max
    dynamic interval = getPropertyValue(validProperties, propertyKey);

    if (interval != null) {
      min = getPropertyValue(interval, "min");
      max = getPropertyValue(interval, "max");
    }
  }
  
  // Giltigt intervall
  String promptExtension = "";
  {
    if (min != null && max != null)  {
        promptExtension += " ($min-$max)";      
    }
    else if (min != null)  {
        promptExtension += " (>=$min)";    
    }
    else if (max != null)  {
        promptExtension += " (<=$max)";       
    }
  }

  // Lägg till ev intervall till prompt så att användaren ser vad som är giltigt
  prompt += "$promptExtension: ";


  int? selectedValue;
  {
    // Frågar efter värde tills användaren angvit giltigt värde
    while (selectedValue == null)
    {
      String? s = _getValueFromUser(prompt);
      s = s?.trim();
    
      selectedValue = int.tryParse(s ?? '');

      if (selectedValue != null) {     
        if ((min != null && selectedValue < min) || (max != null && selectedValue > max))  {
          selectedValue  = null;  // om inte är i intervall, sätt till null
        }           
      }

      // Om värde är null här, är det ogiltigt
      if (selectedValue == null) {
        print('Ogiltigt värde.');
      }
    }
  }
  return selectedValue;
}


// Skriver ut en prompt och returnerar den sträng som användaren skrivit in
String? _getValueFromUser(String prompt) {
  stdout.write(prompt);
  String? value = stdin.readLineSync();
  return value;
}