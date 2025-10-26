import 'dart:io';

void clearScreen() {
  print("\x1B[2J\x1B[0;0H");
  print("------------------------------------------------------------------------------------------------");
  print("");
}


/// Ställer fråga till användaren som kan besvaras med ett av två värden.
bool acceptOrDecline(String prompt, String acceptAnswer, String declineAnswer) {

   bool? accept;
  
   while(accept == null) {

      // Fråga användaren
      stdout.write(prompt);
      String? input = stdin.readLineSync();

      if (input != null) {
        input = input.trim();   
      }

      // Kontrollera att svaret är antingen acceptAnswer eller declineAnswer
      if (input == acceptAnswer) {
        accept = true;
      } 
      else if (input == declineAnswer) {
        accept = false;    
      } 
      else {
        print('Ogiltigt svar. Svara $acceptAnswer eller $declineAnswer.');
      }
    }  

    // Om inmatat svar är acceptAnswer
    return accept == true;
}


/// Frågar användaren efter en sträng tills en giltigt värde anges.
String getStringFromUser(String prompt, { List<String>? validValues, int minLength = 0 })
{
  String? value;
  
  // Lista med valbara alternativ, separerade med /   
  String optionsString = "";
  {   
    if (validValues != null && validValues.isNotEmpty)  {
        optionsString += " (";
        for (int i=0; i<validValues.length; i++) {
          optionsString += (i>0? "/":"") + validValues[i];
        }
        optionsString += ")";
    }
  }

  prompt += "$optionsString: ";

  // Kör tills vi får en giltig sträng
  while(value == null) {

    // Fråga användaren efter en sträng    
    value = _getValueFromUser(prompt);

    // Kontrollera att inmatningen är giltig
    if (value != null && validValues != null && validValues.isNotEmpty) {    
      if (!validValues.contains(value)) value = null;  // om ogiltig, sätt till null
    }

    if (value != null && minLength > 0 && value.length < minLength) {
      value = null;
    }

    // Om sträng är null här, var inmatningen ogiltig
    if (value == null) {

      // Skapa felmeddelande med giltiga alternativ
      String errorMessage;
      {
        errorMessage = 'Ogiltig inmatning';

        if (validValues != null && validValues.isNotEmpty){
          errorMessage += ". Ange ";
          for (int i = 0; i < validValues.length; i++) {
            errorMessage += validValues[i];
            if (i < validValues.length - 2) {  // om inte sista eller näst sista
              errorMessage += ', ';
            } else if (i == validValues.length - 2) {  // om är näst sista
              errorMessage += ' eller ';
            }
          }
        }
        else if (minLength > 0) {
          errorMessage +=". Ange minst $minLength tecken";
        }
        errorMessage += '.';
      }

      print(errorMessage);
    }
  }
 
  return value;
}




/// Frågar användaren efter ett heltal tills ett giltigt heltal anges.
int getIntegerFromUser(String prompt, int? min, int? max) {  
  
  int? value;

  String? optionsString = "";
  {
    // Giltigt intervall            
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

  prompt += "$optionsString: ";

  // Kör tills vi får ett giltigt heltal
  while (value == null) {

    // Fråga användaren efter ett heltal   
    String? input = _getValueFromUser(prompt);

    // Försök att översätta inmatningen till ett heltal
    value = int.tryParse(input ?? '');   

    // Kontrollera inmatat värde.
    if (value == null) {      
      print('Ogiltig inmatning. Ange ett heltal.');
    }
    else if ((min != null && value < min) || (max != null && value > max)) {
      String? interval;
      if (min!=null && max!=null) {
          interval = " som inte är mindre än $min och inte större än $max.";
      }
      else if (min!=null) {
        interval = " som inte är mindre än $min.";
      }
      else if (max!=null) {
        interval = " som inte ärstörre än $max.";
      }
      else {
        interval = ".";
      }

      print('Ogiltig inmatning. Ange ett heltal$interval');

      value = null; // Se till att värdet är ogiltigt så att loop fortsätter
    } 
  }

  return value;
}


// Skriver ut en prompt och returnerar den sträng som användaren skrivit in
String? _getValueFromUser(String prompt) {
  stdout.write(prompt);
  String? value = stdin.readLineSync();
  value = value?.trim();
  return value;
}


void waitForEnter(String prompt) {
   print(prompt);
   stdin.readLineSync(); // väntar tills användaren trycker Enter
}