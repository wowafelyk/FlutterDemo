import 'package:flutter_demo/domain/entities/video_entity.dart';

abstract class VideoState {
  const VideoState._(this.status);

  final VideoStateStatus status;
}

enum VideoStateStatus { initial, loading, success, failure }

class InitialState extends VideoState {
  InitialState() : super._(VideoStateStatus.initial);
}

class LoadingVideoState extends VideoState {
  LoadingVideoState() : super._(VideoStateStatus.loading);
}

class SuccessfulLoadingState extends VideoState {
  SuccessfulLoadingState(this.videosList) : super._(VideoStateStatus.success);

  final List<VideoEntity> videosList;
}

class ErrorLoadingState extends VideoState {
  ErrorLoadingState(this.message) : super._(VideoStateStatus.failure);

  final String message;
}
