import 'package:flutter_demo/domain/entities/video_entity.dart';

abstract class VideoEvent {}

class VideoSearchEvent extends VideoEvent {
  final String searchString;

  VideoSearchEvent({required this.searchString});
}

class VideoLoadingError extends VideoEvent {
  VideoLoadingError(this.message);

  final String message;
}

class VideoLoadingSuccess extends VideoEvent {
  VideoLoadingSuccess(this.videos);

  final List<VideoEntity> videos;
}
