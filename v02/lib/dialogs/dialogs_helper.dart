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


/// Frågar användaren efter ett heltal tills ett giltigt heltal anges.
int getIntegerFromUser(String prompt, int? min, int? max) {  
  
  int? value;

  // Kör tills vi får ett giltigt heltal
  while (value == null) {

    // Fråga användaren efter ett heltal
    stdout.write(prompt);
    String? input = stdin.readLineSync();

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

  // Returnera valt tal
  return value;
}




void waitForEnter(String prompt) {
   print(prompt);
   stdin.readLineSync(); // väntar tills användaren trycker Enter
}