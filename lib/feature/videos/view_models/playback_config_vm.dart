import 'package:flutter/material.dart';
import 'package:tictokclone/feature/videos/models/playback_config_model.dart';
import 'package:tictokclone/feature/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final PlaybackCOnfigRepository _repository;
  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.isMuted(),
    autoplay: _repository.isAutoplay(),
  );

  PlaybackConfigViewModel(
    this._repository,
  );

  bool get muted => _model.muted;
  bool get autoplay => _model.autoplay;

  void setMuted(bool value) {
    //데이터 저장
    _repository.setMuted(value);
    //데이터 수
    _model.muted = value;
    notifyListeners();
  }

  void setAutoPlay(bool value) {
    _repository.setAutoplay(value);
    notifyListeners();
  }
}
