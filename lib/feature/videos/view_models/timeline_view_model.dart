import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictokclone/feature/videos/models/video_model.dart';
import 'package:tictokclone/feature/videos/repos/videos_repo.dart';

//API 로부터 얻어온 값을 제공할 것이기 때문에 AsyncNotifier을 사용한다.
class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
   List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videosRepo);
    final result = await _repository.fetchVideos();
    //map은 새로운 것을 생성함
    //result에 있는 모든 documents 대해서 (video) => 1 함수들을 실행함 ==> 리스트에 모두 1이 들어감
    //무엇을 리턴하든지 newList에 넣을 거다
    final newList = result.docs.map(
      // => 는 임시적 반환을 해준다 {} 를 사용할 경우에는 아무것도 반환하지 않
      (doc) => VideoModel.fromJson(
        doc.data(),
      ),
    );
    _list = newList.toList();

    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
