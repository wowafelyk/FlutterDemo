import 'package:flutter_demo/data/datasources/omdb_video_datasource.dart';
import 'package:flutter_demo/data/datasources/remote_video_datasource.dart';
import 'package:flutter_demo/data/http/dio_factory_impl.dart';
import 'package:flutter_demo/data/http/dio_http_client.dart';
import 'package:flutter_demo/data/http/http_client.dart';
import 'package:flutter_demo/data/repository/secure_repository_impl.dart';
import 'package:flutter_demo/data/repository/settings_repository_impl.dart';
import 'package:flutter_demo/data/repository/video_repository_impl.dart';
import 'package:flutter_demo/domain/repository/secure_repository.dart';
import 'package:flutter_demo/domain/repository/settings_repository.dart';
import 'package:flutter_demo/domain/repository/video_repository.dart';
import 'package:flutter_demo/injection/injector.dart';
import 'package:flutter_demo/presentation/block/videos_list_block.dart';

class MainModule {
  static Future<void> inject() async {
    //TODO: Temporary singleton solution
    injector.registerLazySingleton(
      () => VideosListBloc(videosRepository: injector()),
    );

    injector.registerFactory<VideoRepository>(
        () => VideoRepositoryImpl(injector()));

    injector.registerLazySingleton<HttpClient>(() => DioHttpClient(
        DioFactoryImpl(injector.get<SettingsRepository>().getOMDBBaseUrl())
            .create()));

    injector.registerSingleton<SettingsRepository>(SettingsRepositoryImpl());

    injector.registerFactory<RemoteVideoDatasource>(
        () => OmdbVideoDatasource(injector(), injector()));

    injector.registerFactory<SecureRepository>(() => SecureRepositoryImpl());
  }
}
