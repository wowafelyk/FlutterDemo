import 'package:flutter_demo/data/models/omdb_video_search_response.dart';
import 'package:flutter_demo/domain/entities/video_entity.dart';

class VideoEntityMapper {
  static VideoEntity fromOmdbSearchModel(Search model) {
    return VideoEntity(
      name: model.title,
      poster: model.poster,
      year: model.year,
      type: model.type,
      imdbID: model.imdbID,
    );
  }

  static List<VideoEntity> fromOmdbSearchModelResponse(
      OmdbSearchVideosResponse response) {
    return response.search.map((e) => fromOmdbSearchModel(e)).toList();
  }
}
