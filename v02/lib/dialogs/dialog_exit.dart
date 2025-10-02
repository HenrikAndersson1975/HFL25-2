import 'dialogs_helper.dart';

bool dialogExit() {

  bool exit = false;
  
  clearScreen();
  print('--- Avsluta ---');

  // fråga om användaren vill avsluta       
  exit = acceptOrDecline("Är du säker på att du vill avsluta programmet? (j/n) ", "j", "n");
  
  return exit;
}