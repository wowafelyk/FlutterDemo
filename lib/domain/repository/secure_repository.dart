abstract class SecureRepository {
  Future<void> init();

  String getTMDBApiKey();

  String getOMDBApiKey();
}
