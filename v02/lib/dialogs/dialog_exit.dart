import 'dialogs_helper.dart';

/// Frågar om användaren vill avsluta programmet.
/// Returnerar true och användaren vill avsluta.
bool dialogExit() {

  bool exit = false;
  
  clearScreen();
  print('--- Avsluta ---');

  // fråga om användaren vill avsluta       
  exit = acceptOrDecline("Är du säker på att du vill avsluta programmet? (j/n) ", "j", "n");
  
  return exit;
}