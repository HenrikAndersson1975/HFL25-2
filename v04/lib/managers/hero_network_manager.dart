
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/api_key_service.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/interfaces/hero_network_managing.dart';

class HeroNetworkManager implements HeroNetworkManaging {

  @override
  Future<List<HeroModel>?> getHeroesByName(String searchPattern) async {

    List<HeroModel>? returnList;  // Lista initieras om status 200

    String encodedSearchPattern = Uri.encodeComponent(searchPattern); // Koda om tecken så att de fungerar i url

    final apiKey = getApiKey(); // Hämta nyckel från fil

    try {

      final url = Uri.parse('https://superheroapi.com/api/$apiKey/search/$encodedSearchPattern'); 

      // Vänta på svar från server
      final responseFromService = await http.get(url);

      // Kontrollera om förfrågan var framgångsrik (statuskod 200)
      if (responseFromService.statusCode == 200) {     

        returnList = [];

        dynamic body = jsonDecode(responseFromService.body);
        bool success = (body['response'] ?? '') == 'success';

        if (success) {
          
          List<dynamic> resultsList = body['results']; // I listan ligger json för de hjältar som servern returnerat

          // Skapa HeroModel för varje result
          for(int i=0; i<resultsList.length; i++) {
            dynamic oneHeroJson = resultsList[i];
            var hero = HeroModel.fromJson(oneHeroJson);
            returnList.add(hero);
          }
        }
      
      } else {
        // Hantera fel om förfrågan misslyckades
        print('Fel vid hämtning av data: ${responseFromService.statusCode}');
      }
    }
    catch (e) {
      print(e);
    }

    return returnList;
  } 
}