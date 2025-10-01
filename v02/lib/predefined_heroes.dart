
List<Map<String, dynamic>> getPredefinedHeroes() {
  List<Map<String, dynamic>> heroes = [
      {
        "id": "1",

        "name": "Lisa",
        "powerstats": {
          "strength": "12"      
        },
        "appearance": {
          "gender": "Kvinna",
          "race": "Människa",
        },
        "biography": {
          "alignment": "god",
        }
      },
      {
        "id": "2",

        "name": "Janne",
        "powerstats": {
          "strength": "100"         
        },
        "appearance": {
          "gender": "Man",
          "race": "Människa",
        },
        "biography": {
          "alignment": "ond",
        }
      },
      {
        "id": "3",

        "name": "Klas",
        "powerstats": {
          "strength": "20"         
        },
        "appearance": {
          "gender": "Man",
          "race": "Människa",
        },
        "biography": {
          "alignment": "god",
        }
      },  
      {
        "id": "4",

        "name": "Petra",
        "powerstats": {
          "strength": "88"         
        },
        "appearance": {
          "gender": "Kvinna",
          "race": "Människa",
        },
        "biography": {
          "alignment": "god",
        }
      }
    ];

  return heroes;
}