import 'dart:io';

bool writeHeroesToFile(String filePath, List<Map<String, dynamic>> heroes) {


  return false;
}



List<Map<String, dynamic>> readHeroesFromFile(String filePath) {
  return [];
}


bool isExistingFilePath(String filePath) {
  File file = File(filePath);
  bool exists = file.existsSync();
  return exists;
}