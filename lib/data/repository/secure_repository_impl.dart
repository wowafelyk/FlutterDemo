import 'package:flutter_demo/domain/repository/secure_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecureRepositoryImpl implements SecureRepository {
  @override
  Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }

  @override
  String getTMDBApiKey() {
    return dotenv.get('tmdb_api_key');
  }

  @override
  String getOMDBApiKey() {
    return dotenv.get('omdb_api_key');
  }
}
