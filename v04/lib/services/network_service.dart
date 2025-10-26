import 'package:http/http.dart' as http;

class NetworkService {
  
  static final NetworkService _instance = NetworkService._privateConstructor();

  NetworkService._privateConstructor();

  factory NetworkService() {   
    return _instance;
  }
 
  Future<String> get(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;  
    } else {
      throw Exception('Error: ${response.statusCode}');     
    }
  }
}