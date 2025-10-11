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
  if (suggestedFile != null) {
       
    bool useSuggestedFilePath = acceptOrDecline("Vill du använda $suggestedFile? (j/n) ", "j", "n");
   
    // Om förslaget godtogs
    if (useSuggestedFilePath) {
      selectedFile = suggestedFile;
    }
  }

  // Om det inte finns någon vald fil
  if (selectedFile == null) {
    
    // Fråga användaren 
    stdout.write("Ange fil: ");
    String? input = stdin.readLineSync();

    if (input != null) {
      input = input.trim();   
    }

    selectedFile = input;
  }

  return selectedFile;
}