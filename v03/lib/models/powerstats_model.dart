class Powerstats {
   int? intelligence;
   int? strength;
   int? speed;
   int? durability;
   int? power;
   int? combat;

  Powerstats({
     this.intelligence,
     this.strength,
     this.speed,
     this.durability,
     this.power,
     this.combat,
  });

  factory Powerstats.fromJson(Map<String, dynamic>? json) {
    return Powerstats(
      intelligence: _toInt(json?['intelligence']),
      strength: _toInt(json?['strength']),
      speed: _toInt(json?['speed']),
      durability: _toInt(json?['durability']),
      power: _toInt(json?['power']),
      combat: _toInt(json?['combat']),
    );
  }
  static int? _toInt(dynamic value) {     
      if (value == null) { return null; }
      else if (value is int) { return value; }
      else if (value is String) { return int.tryParse(value); }
      else { return null; } 
    }

  Map<String, dynamic> toJson() {
    return {
      'intelligence': intelligence?.toString(),
      'strength': strength?.toString(),
      'speed': speed?.toString(),
      'durability': durability?.toString(),
      'power': power?.toString(),
      'combat': combat?.toString(),
    };
  }
}



