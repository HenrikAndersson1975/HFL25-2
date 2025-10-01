import 'dart:io';




void printHeroes(List<Map<String, dynamic>> heroes) {
  for (var hero in heroes) {
    printHero(hero);
  }
}

void printHero(Map<String, dynamic> hero) {
  String name = hero['name'] ?? 'Okänt namn';
  String strength = hero['powerstats']?['strength'] ?? 'Okänd styrka';
  print('Namn: $name, Styrka: $strength');
}


void clearScreen() {
  print("\x1B[2J\x1B[0;0H");
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


void waitForEnter(String prompt) {
   print(prompt);
   stdin.readLineSync(); // väntar tills användaren trycker Enter
}