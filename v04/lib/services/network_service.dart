import 'package:http/http.dart' as http;
import 'dart:async';

class NetworkService {
  
  static final NetworkService _instance = NetworkService._privateConstructor();

  NetworkService._privateConstructor();

  factory NetworkService() {   
    return _instance;
  }
 
  Future<String> get(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return response.body;  
      } else {
        throw Exception('Error: ${response.statusCode}');     
      }
    }
    on TimeoutException catch (e) {
      throw Exception('API-anropet tog för lång tid: $e');
    }
    catch (e) {
      rethrow; 
    }    
  }
}