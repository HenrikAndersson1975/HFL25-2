import 'dart:io';
import 'dart:convert';


/// Inga exceptions hanteras här


void writeHeroesToFile(String filePath, List<Map<String, dynamic>> heroes) {

  
    // Konvertera listan till JSON
    String jsonString = jsonEncode(heroes);

    // Skapa en fil
    File file = File(filePath);

    // Skriv JSON-strängen till filen
    file.writeAsString(jsonString);
  
}




List<Map<String, dynamic>> readHeroesFromFile(String filePath) {


  File file = File(filePath);
  String jsonString = file.readAsStringSync();

  // Konvertera JSON-strängen tillbaka till en lista
  List<dynamic> jsonList = jsonDecode(jsonString);

  // Konvertera listan till List<Map<String, dynamic>>
  List<Map<String, dynamic>> heroes = jsonList.map((hero) => Map<String, dynamic>.from(hero)).toList();
  

  return heroes;
}





bool isExistingFilePath(String filePath) {
  File file = File(filePath);
  bool exists = file.existsSync();
  return exists;
}