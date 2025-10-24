import 'package:dotenv/dotenv.dart';
String getApiKey() {
  final DotEnv env = DotEnv(); env.load();  // ladda .env-filen
  final apiKey = env['API_KEY'] ?? '';  // leta upp nyckel i fil
  return apiKey;
}

