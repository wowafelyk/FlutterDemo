import 'package:flutter_demo/data/datasources/remote_video_datasource.dart';
import 'package:flutter_demo/data/http/http_client.dart';
import 'package:flutter_demo/data/mappers/video_entity_mapper.dart';
import 'package:flutter_demo/data/models/omdb_video_search_response.dart';
import 'package:flutter_demo/domain/entities/video_entity.dart';
import 'package:flutter_demo/domain/repository/secure_repository.dart';

class OmdbVideoDatasource extends RemoteVideoDatasource {
  OmdbVideoDatasource(
    this._httpClient,
    this._secureRepository,
  );

  static const queryKeyApi = 'apikey';
  static const queryKeyVideoTitle = 's';
  static const queryKeyPage = 'page';

  final HttpClient _httpClient;
  final SecureRepository _secureRepository;

  @override
  Future<List<VideoEntity>> getVideos({required String videoTitle}) async {
    Map<String, dynamic>? queryParameters = {
      queryKeyApi: _secureRepository.getOMDBApiKey(),
      queryKeyVideoTitle: videoTitle,
      queryKeyPage: 1,
    };
    return _httpClient.get('', queryParameters: queryParameters).then((value) {
      return VideoEntityMapper.fromOmdbSearchModelResponse(
          OmdbSearchVideosResponse.fromJson(value));
    });
  }
}
