import 'dart:io';
import 'tokens.dart';

/// Frågar användaren efter ett heltal tills ett giltigt heltal anges.
NumberToken getIntegerFromUser(String prompt) {  
  
  int? value;

  // Kör tills vi får ett giltigt heltal
  while (value == null) {

    // Fråga användaren efter ett heltal
    stdout.write(prompt);
    String? input = stdin.readLineSync();

    // Försök att översätta inmatningen till ett heltal
    value = int.tryParse(input ?? '');   
    if (value == null) {      
      print('Ogiltig inmatning. Ange ett heltal.');
    }
  }

  // Skapa och returnera en NumberToken
  return NumberToken(value);
}



/// Frågar användaren efter en operator tills en giltig operator anges.
OperatorToken getOperatorFromUser(String prompt, List<String> validOperators) { 

  String? operator;
  
  // Kör tills vi får en giltig operator
  while(operator == null) {

    // Fråga användaren efter en operator
    stdout.write(prompt);
    operator = stdin.readLineSync();

    // Kontrollera att inmatningen är giltig
    if (operator != null) {
      operator = operator.trim(); 
      if (!validOperators.contains(operator)) operator = null;  // om ogiltig, sätt till null
    }

    // Om operator är null här, var inmatningen ogiltig
    if (operator == null) {

      // Skapa felmeddelande med giltiga alternativ
      String errorMessage;
      {
        errorMessage = 'Ogiltig inmatning. Ange ';
        for (int i = 0; i < validOperators.length; i++) {
          errorMessage += validOperators[i];
          if (i < validOperators.length - 2) {  // om inte sista eller näst sista
            errorMessage += ', ';
          } else if (i == validOperators.length - 2) {  // om är näst sista
            errorMessage += ' eller ';
          }
        }
        errorMessage += '.';
      }

      print(errorMessage);
    }
  }

  // Skapa och returnera en OperatorToken
  return OperatorToken(operator);
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