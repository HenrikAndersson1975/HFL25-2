import 'dart:io';

/// Extensions för "hjälte-objektlista"
extension ListMapExtensions on List<Map<String, dynamic>> {
  
  List<Map<String, dynamic>> findHeroesByName(String pattern, bool caseSensitive) {
    String searchPattern = caseSensitive ? pattern : pattern.toLowerCase();

    // Sök i listan efter hjältar vars namn innehåller söksträngen
    return where((hero) {
      String name = (hero['name'] ?? '');
      if (!caseSensitive) {
        name = name.toLowerCase();
      }   
      return name.contains(searchPattern);  // Kollar om söksträngen finns i namnet
    }).toList();
  }


  void orderHeroesByStrength() {
    sort((a, b) {
      int strengthA = int.tryParse(a['powerstats']?['strength'] ?? '0') ?? 0;
      int strengthB = int.tryParse(b['powerstats']?['strength'] ?? '0') ?? 0;
      return strengthB.compareTo(strengthA); // Sortera i fallande ordning
    });
  }
  void orderHeroesById() {
    sort((a, b) {
      int idA = int.tryParse(a['id'] ?? '0') ?? 0;
      int idB = int.tryParse(b['id'] ?? '0') ?? 0;
      return idA.compareTo(idB); // Sortera i stigande ordning
    });
  }
  

  void addHeroToList(Map<String, dynamic>? newHero) {
    if (newHero != null) {
      int newHeroId = _getNextHeroId();   // ta fram nästa lediga id
      newHero['id'] = newHeroId.toString();  // tilldela id till hjälte
      add(newHero);  // Lägg till den nya hjälten i listan
    }
  }


  int _getNextHeroId() {       
    int maxId = 0;
    for (var hero in this) {
      int id = int.tryParse(hero['id'] ?? '0') ?? 0;
      if (id > maxId) {
        maxId = id;
      }
    }
    return maxId + 1; // nästa tillgängliga id   
  }
}

/// Extensions till "hjälte-objekt"
extension MapExtensions on Map<String, dynamic> {

  // Skriv ut hjältens egenskaper till skärm
  void printHero() {
    Map<String, dynamic> hero = this;
    String name = hero['name'] ?? 'Okänt namn';
    String strength = hero['powerstats']?['strength'] ?? 'Okänd styrka';
    stdout.writeln('Namn: $name, Styrka: $strength');
  }
}