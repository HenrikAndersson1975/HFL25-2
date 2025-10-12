
class Biography {
   String? fullName;
   String? alterEgos;
   List<String>? aliases;
   String? placeOfBirth;
   String? firstAppearance;
   String? publisher;
   String? alignment;

  Biography({
     this.fullName,
     this.alterEgos,
     this.aliases,
     this.placeOfBirth,
     this.firstAppearance,
     this.publisher,
     this.alignment,
  });

  factory Biography.fromJson(Map<String, dynamic>? json) {
    return Biography(
      fullName: json?['full-name'],
      alterEgos: json?['alter-egos'],
      aliases: (json?['aliases'] is List)
        ? List<String>.from(json?['aliases'] as List)
        : null,
      placeOfBirth: json?['place-of-birth'],
      firstAppearance: json?['first-appearance'],
      publisher: json?['publisher'],
      alignment: json?['alignment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full-name': fullName,
      'alter-egos': alterEgos,
      'aliases': aliases,
      'place-of-birth': placeOfBirth,
      'first-appearance': firstAppearance,
      'publisher': publisher,
      'alignment': alignment,
    };
  }
}