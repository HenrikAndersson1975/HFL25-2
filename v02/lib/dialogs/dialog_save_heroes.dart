import '../file.dart' as file;
import 'dialog_file_path.dart';
import 'dialogs_helper.dart';


/// Användaren ges möjlighet att spara hjältarna till en fil
void dialogSaveHeroes(List<Map<String, dynamic>> heroes, String? filePath) {

    bool trySave = true;

    // om användaren vill spara till fil
    while (trySave) {
      
      // frågar användaren efter en fil att spara hjältarna till, skickar med ett förslag 
      String? savePath = dialogFilePath("--- Spara hjältar till fil ---", filePath);

      // försöker att spara hjältarna till fil
      bool trySaveSuccess = _trySaveHeroes(heroes, savePath);

      // om det gick bra, försök inte att spara igen
      if (trySaveSuccess) {
        trySave = false;  
      }

      // om det inte gick bra, ge användaren möjlighet att ange annan fil att spara till
      else {    
        // 
        if (savePath != null) {
          print('Det gick inte att spara till $savePath.');
        }

        // Fråga om man vill försöka igen
        trySave = acceptOrDecline("Vill du försöka att spara till en annan fil? (j/n) ", "j", "n");
      }
    }
}



/// Sparar hjältar till fil 
bool _trySaveHeroes(List<Map<String, dynamic>> heroes, String? savePath) {  

  bool success = false;
  
  if (savePath != null) {
    try {
      print('Sparar hjältar till fil...');
      file.writeHeroesToFile(savePath, heroes);
      print('Klar.');
      success = true;
    }
    catch (e) {
      print('Fel vid skrivning till fil: $e');
      success = false;
    }
  }  
  else {
    print('Ingen fil har angivits.');
  }

  return success;
}