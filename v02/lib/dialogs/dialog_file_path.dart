import 'dialogs_helper.dart';
import 'dart:io';

String? dialogFilePath(String? suggestedFile) {

  String? selectedFile;

  // om det finns en förslagen fil, fråga om användaren vill använda den
  if (suggestedFile != null) {
    
    bool useSuggestedFilePath = acceptOrDecline("Vill du använda $suggestedFile? (j/n) ", "j", "n");
   
    // om förslaget godtogs
    if (useSuggestedFilePath) {
      selectedFile = suggestedFile;
    }
  }

  // om det inte finns någon vald fil
  if (selectedFile == null) {
    
    // fråga användaren 
    stdout.write("Ange fil: ");
    String? input = stdin.readLineSync();

    if (input != null) {
      input = input.trim();   
    }

    selectedFile = input;
  }

  return selectedFile;
}