
/// Returnerar nästa tillgängliga Id för en ny hjälte
int getNextHeroId(List<Map<String, dynamic>> heroes) {
  int maxId = 0;

  for (var hero in heroes) {
    int id = int.tryParse(hero['id'] ?? '0') ?? 0;
    if (id > maxId) {
      maxId = id;
    }
  }

  return maxId + 1; // nästa tillgängliga Id
}


/// Söker efter hjältar vars namn innehåller den angivna söksträngen
List<Map<String, dynamic>> findHeroesByName(List<Map<String, dynamic>> heroes, String pattern, bool caseSensitive) {
    String searchPattern = caseSensitive ? pattern : pattern.toLowerCase();

    // söker i listan efter hjältar vars namn innehåller söksträngen
    List<Map<String, dynamic>> matchingHeroes = heroes.where((hero) {
      String name = (hero['name'] ?? '');
      if (!caseSensitive) {
        name = name.toLowerCase();
      }   
      return name.contains(searchPattern);  // kollar om söksträngen finns i namnet
    }).toList();

    return matchingHeroes;
}



/// Sorterar listan av hjältar efter deras styrka, starkaste först
void orderHeroesByStrength(List<Map<String, dynamic>> heroes) {
  heroes.sort((a, b) {
    int strengthA = int.tryParse(a['powerstats']?['strength'] ?? '0') ?? 0;
    int strengthB = int.tryParse(b['powerstats']?['strength'] ?? '0') ?? 0;
    return strengthB.compareTo(strengthA); // Sortera i fallande ordning
  });
}
