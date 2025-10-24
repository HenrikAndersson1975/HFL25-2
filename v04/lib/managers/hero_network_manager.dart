import 'dart:convert';
import '../services/api_key_service.dart';
import 'package:v04/models/exports_hero_models.dart';
import 'package:v04/interfaces/hero_network_managing.dart';
import 'package:v04/services/network_service.dart';

class HeroNetworkManager implements HeroNetworkManaging {

  // FileService-instans som hanterar filen 'filePath'
  final NetworkService _networkService;
  
  // Factory för att skapa instans av HeroFileManager
  factory HeroNetworkManager() {
    return HeroNetworkManager._(NetworkService());
  }
  
  // Privat konstruktor
  HeroNetworkManager._(this._networkService);

  @override
  Future<(bool success, List<HeroModel> heroes)> findHeroesByName(String searchPattern) async {

    bool success =  false;
    List<HeroModel>? returnList;  
    

    String encodedSearchPattern = Uri.encodeComponent(searchPattern); // Koda om tecken så att de fungerar i url

    final apiKey = getApiKey(); // Hämta nyckel från fil

    String url = 'https://superheroapi.com/api/$apiKey/search/$encodedSearchPattern'; 

    try {
      // Vänta på svar från server
      final responseFromService = await _networkService.get(url);

      dynamic body = jsonDecode(responseFromService);

      success = (body['response'] ?? '') == 'success';

      if (success) {
      
        List<dynamic> resultsList = body['results']; // I listan ligger json för de hjältar som servern returnerat
        returnList = [];

        // Skapa HeroModel för varje result
        for(int i=0; i<resultsList.length; i++) {
          dynamic oneHeroJson = resultsList[i];
          var hero = HeroModel.fromJson(oneHeroJson);
          returnList.add(hero);
        }           
      }
    }
    catch (e) {
        print(e);
    }
      
    return (success, returnList ?? []);
  } 
}