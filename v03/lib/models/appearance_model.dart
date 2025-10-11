class Appearance {
   String? gender;
   String? race;
   List<String?>? height;
   List<String?>? weight;
   String? eyeColor;
   String? hairColor;

  Appearance({
     this.gender,
     this.race,
     this.height,
     this.weight,
     this.eyeColor,
     this.hairColor,
  });

  factory Appearance.fromJson(Map<String, dynamic>? json) {
    return Appearance(
      gender: json?['gender'],
      race: json?['race'],
      height: (json?['height'] is List)
          ? List<String>.from(json?['height'] as List)
          : null,
      weight: (json?['weight'] is List)
          ? List<String>.from(json?['weight'] as List)
          : null,
      eyeColor: json?['eye-color'],
      hairColor: json?['hair-color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'race': race,
      'height': height,
      'weight': weight,
      'eye-color': eyeColor,
      'hair-color': hairColor,
    };
  }
}