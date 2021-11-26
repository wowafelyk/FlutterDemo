import 'package:flutter_demo/data/datasources/remote_video_datasource.dart';
import 'package:flutter_demo/domain/entities/video_entity.dart';
import 'package:flutter_demo/domain/repository/video_repository.dart';

class VideoRepositoryImpl extends VideoRepository {
  VideoRepositoryImpl(this._remoteVideoDatasource);

  final RemoteVideoDatasource _remoteVideoDatasource;

  @override
  Future<List<VideoEntity>> loadVideo({required String videoTitle}) async {
    return await _remoteVideoDatasource.getVideos(videoTitle: videoTitle);
  }
}
