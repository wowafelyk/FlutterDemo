import 'package:flutter_demo/core/const.dart';
import 'package:flutter_demo/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  @override
  String getOMDBBaseUrl() {
    return Const.omdbApiUrl;
  }
}
