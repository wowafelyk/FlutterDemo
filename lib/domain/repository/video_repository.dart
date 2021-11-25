import 'package:flutter_demo/domain/entities/video_entity.dart';

abstract class VideoRepository {
  Future<List<VideoEntity>> loadVideo();
}
