import 'dialogs_helper.dart';
import 'dart:io';

/// Frågar användaren efter en fil
/// Om suggestedFile inte är null, kommer användaren först få fråga om den vill använda den filen.
String? dialogFilePath(String? header, {String? suggestedFile}) {

  String? selectedFile;

  clearScreen();

  if (header!=null) {
    print(header);
  }

  // Om det finns en förslagen fil, fråga om användaren vill använda den
  if (suggestedFile != null && suggestedFile.isNotEmpty) {
       
    if (_isValidFileName(suggestedFile)) {

      bool useSuggestedFilePath = acceptOrDecline("Vill du använda $suggestedFile? (j/n) ", "j", "n");
      
      if (useSuggestedFilePath) {
        selectedFile = suggestedFile;
      }
    }
    else {
      print('Föreslaget filnamn, $suggestedFile, är ogiltigt. Du måste ange annat namn.');
    }
  }

  // Om det inte finns någon vald fil
  if (selectedFile == null) {
    
    // Fråga användaren 
    stdout.write("Ange fil: ");
    String? input = stdin.readLineSync();
    input?.trim(); 
    
    if (_isValidFileName(input)) {
      selectedFile = input;
    }
    else {
      print('Ogiltigt filnamn.');
    }
  }

  return selectedFile;
}

bool _isValidFileName(String? fileName) {
  // mycket slappt
  return fileName!=null && fileName.length>3 && fileName.contains(('.'));
}