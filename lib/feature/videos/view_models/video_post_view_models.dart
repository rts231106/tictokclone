import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictokclone/feature/authentication/repos/authentication_repo.dart';
import 'package:tictokclone/feature/videos/repos/videos_repo.dart';

// familyAsyncNotifier는 Notifier에게 추가 인자를 보낼 수 있게 도와줌
class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final String _videoId;

  @override
  FutureOr<void> build(String arg) {
    _videoId = arg;
    _repository = ref.read(videosRepo);
  }

  Future<void> likeVideo() async {
    //어떤 유저가 비디오를 좋아하는지 알아야함 
    final user = ref.read(authRepo).user;
    await _repository.likeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
