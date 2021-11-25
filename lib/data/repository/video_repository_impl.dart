import 'package:flutter_demo/domain/entities/video_entity.dart';
import 'package:flutter_demo/domain/repository/video_repository.dart';

class VideoRepositoryImpl extends VideoRepository {
  @override
  Future<List<VideoEntity>> loadVideo() async {
    throw UnimplementedError();
  }
}
