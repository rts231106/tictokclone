import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictokclone/feature/videos/models/video_model.dart';

//API 로부터 얻어온 값을 제공할 것이기 때문에 AsyncNotifier을 사용한다.
class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  void uploadVideo() async {
    state = const AsyncValue.loading();

    await Future.delayed(const Duration(
      seconds: 2,
    ));
    final newVideo = VideoModel(title: "${DateTime.now()}");
    //..._list 기존에 리스트에 있는 모든 것들을 전부 가져옴
    _list = [..._list, newVideo];
    // 우리는 AsyncNotifier 안에 있다
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
