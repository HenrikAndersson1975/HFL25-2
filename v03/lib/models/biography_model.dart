class Biography {
   String? fullName;
   String? alterEgos;
   List<String>? aliases;
   String? placeOfBirth;
   String? firstAppearance;
   String? publisher;
   String? alignment;

  Biography({
    required this.fullName,
    required this.alterEgos,
    required this.aliases,
    required this.placeOfBirth,
    required this.firstAppearance,
    required this.publisher,
    required this.alignment,
  });

  factory Biography.fromJson(Map<String, dynamic> json) {
    return Biography(
      fullName: json['full-name'],
      alterEgos: json['alter-egos'],
      aliases: List<String>.from(json['aliases']),
      placeOfBirth: json['place-of-birth'],
      firstAppearance: json['first-appearance'],
      publisher: json['publisher'],
      alignment: json['alignment'],
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