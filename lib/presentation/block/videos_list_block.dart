import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/core/logger.dart';
import 'package:flutter_demo/domain/repository/video_repository.dart';
import 'package:flutter_demo/presentation/block/video_event.dart';
import 'package:flutter_demo/presentation/block/video_state.dart';

class VideosListBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository _videosRepository;

  VideosListBloc({required VideoRepository videosRepository})
      : _videosRepository = videosRepository,
        super(InitialState()) {
    on<VideoSearchEvent>((VideoSearchEvent event, Emitter<VideoState> emit) =>
        _loadVideos(event, emit));

    on<VideoLoadingSuccess>(
            (VideoLoadingSuccess event, Emitter<VideoState> emit) =>
            emit.call(SuccessfulLoadingState(event.videos)));

    on<VideoLoadingError>((VideoLoadingError event, Emitter<VideoState> emit) =>
        emit.call(ErrorLoadingState(event.message)));
  }

  _loadVideos(VideoSearchEvent event, Emitter<VideoState> emit) {
    emit.call(LoadingVideoState());
    _videosRepository.loadVideo(videoTitle: event.searchString).then((value) {
      add(VideoLoadingSuccess(value));
    }, onError: (err, trace) {
      debugPrintStack(stackTrace: trace);
      logger.e("Error while loading videos $err");
      add(VideoLoadingError(err.toString()));
    });
  }
}
