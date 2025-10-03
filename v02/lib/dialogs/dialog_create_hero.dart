import 'dart:io';
import 'dialogs_helper.dart';
import 'package:v02/hero.dart';


/// Användaren fyller i egenskaper för en hjälte som sedan skapas och returneras.
Map<String, dynamic>? dialogCreateHero() {

  clearScreen();

  print('--- Skapa hjälte ---');
  print('Ange egenskaper för hjälten.');
  String name = _getValidPropertyValueFromUser('Namn', "name");
  int strength = _getValidPropertyValueFromUser('Styrka', "strength");
  String gender = _getValidPropertyValueFromUser('Kön', "gender");
  String alignment = _getValidPropertyValueFromUser('Moralisk inriktning', "alignment");

  Map<String, dynamic>? newHero = createHero(name, strength, gender, alignment);

  
  return newHero;
}


T _getValidPropertyValueFromUser<T>(String prompt, String propertyKey) {

  T? value;

  // lägg till svarsalternativ till prompt
  prompt = _createPromptWithOptions<T>(prompt, propertyKey);

  // Fortsätt tills giltigt värde finns
  while(value == null)
  {
      // Skriv ut prompt
      String ? str = _getValueFromUser(prompt);
      str = str?.trim();

      if (str != null) {      
          value = _castStringToType<T>(str); // översätt inmatad sträng till returntyp
          if (value != null) {
            // Om angiven sträng inte är ett giltigt värde, sätt till null
            if (!isValidPropertyValue(value, propertyKey)) { value = null; }  
          }     
      }

      // Om värde är null här, är det ogiltigt
      if (value == null) {
        print('Ogiltigt värde.');
      }
  }

  return value;
}

T? _castStringToType<T>(String? value) {
  if (T == String) {
    return value as T; 
  } else if (T == int) {
    return int.tryParse(value ?? '') as T?;
  }
  return null; 
}

// Skriver ut en prompt och returnerar den sträng som användaren skrivit in
String? _getValueFromUser(String prompt) {
  stdout.write(prompt);
  String? value = stdin.readLineSync();
  return value;
}

String _createPromptWithOptions<T>(String prompt, String propertyKey) {

  String optionsString = "";
  {
    if (T == int) {
      // Letar upp min- och max-värde för egenskapen
      int? min;
      int? max;
      {       
        // förutsätter att giltiga värden lagras i ett intervall som kan ha min och max
        dynamic interval = getValidPropertyValues(propertyKey);
        if (interval != null) {
          min = getPropertyValue(interval, "min");
          max = getPropertyValue(interval, "max");
        }
      }
      
      // Giltigt intervall       
      {
        if (min != null && max != null)  {
            optionsString += " ($min-$max)";      
        }
        else if (min != null)  {
            optionsString += " (>=$min)";    
        }
        else if (max != null)  {
            optionsString += " (<=$max)";       
        }
      }   
    }
    else if (T == String) 
    {
      // Tar fram giltiga värden för egenskapen
      List<String>? acceptedPropertyValues = getValidPropertyValues(propertyKey);
    
      // Sätter det till null om inga alternativ finns/hittas
      if (acceptedPropertyValues == null || acceptedPropertyValues.isEmpty) {
          acceptedPropertyValues = null;
      }

      // Lista med valbara alternativ, separerade med /    
      {
        if (acceptedPropertyValues != null)  {
            optionsString += " (";
            for (int i=0; i<acceptedPropertyValues.length; i++) {
              optionsString += (i>0? "/":"") + acceptedPropertyValues[i];
            }
            optionsString += ")";
        }
      }
    }
  }

  // Lägg till alternativ till prompt så att användaren ser vad som är giltigt
  prompt += "$optionsString: ";

  return prompt;
}