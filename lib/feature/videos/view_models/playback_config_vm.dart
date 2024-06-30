import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictokclone/feature/videos/models/playback_config_model.dart';
import 'package:tictokclone/feature/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackCOnfigRepository _repository;

  PlaybackConfigViewModel(
    this._repository,
  );

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(muted: value, autoplay: state.autoplay);
  }

  void setAutoPlay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(muted: state.autoplay, autoplay: value);
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(() => 
    throw UnimplementedError(),);
