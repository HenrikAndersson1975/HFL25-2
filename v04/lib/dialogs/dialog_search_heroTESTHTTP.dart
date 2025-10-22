import 'dart:convert';
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:v03/dialogs/dialogs_helper.dart';
import 'package:v03/models/hero_model.dart';

Future<void> dialogSearchHeroTESTHTTP() async {


   await _fetchData();
    waitForEnter("lbafdsaf");
}

Future<void> _fetchData() async {
  // URL till API:et

  final DotEnv env = DotEnv(); env.load();  
  final apiKey = env['API_KEY'] ?? '';

String searchPattern = "iron man";
  
  String encodedSearchPattern = Uri.encodeComponent(searchPattern);

  try {

      // kolla film vid 14:30

    final url = Uri.parse('https://superheroapi.com/api/$apiKey/search/$encodedSearchPattern'); 
    final response = await http.get(url);

    // Kontrollera om förfrågan var framgångsrik (statuskod 200)
    if (response.statusCode == 200) {
      // Konvertera JSON-strängen till ett Dart-objekt
      dynamic body = jsonDecode(response.body);

      var response1 = body['response'];
      List<dynamic> results = body['results'];


      

      for(int i=0; i<results.length; i++) 
      {
        var hero = HeroModel.fromJson(results[i]);

        var s = hero.toDisplayString();

        print(s);

      }

      



      // todo översätt till hero eller heroes

      // Skriv ut datan eller gör något med den
      //print(body);
    } else {
      // Hantera fel om förfrågan misslyckades
      print('Fel vid hämtning av data: ${response.statusCode}');
    }
  }
  catch (e) {
    print(e);
  }
}
