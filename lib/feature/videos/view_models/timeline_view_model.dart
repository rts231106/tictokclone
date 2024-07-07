import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictokclone/feature/videos/models/video_model.dart';
import 'package:tictokclone/feature/videos/repos/videos_repo.dart';

//API 로부터 얻어온 값을 제공할 것이기 때문에 AsyncNotifier을 사용한다.
class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
  List<VideoModel> _list = [];

  //아래 메서드의 역할은 비디오들을 가져오는것
  Future<List<VideoModel>> _fetchVideos({
    int? lastItemCreatedAt,
  }) async {
    _repository = ref.read(videosRepo);

    final result =
        await _repository.fetchVideos(lastItemCreatedAt: lastItemCreatedAt);
// 우리에게 데이터를 보내고 있지만 데이터에 id를 만들어야함 
    final videos = result.docs.map(
      (doc) => VideoModel.fromJson(
        json: doc.data(),
        videoId : doc.id,
      ),
    );
    return videos.toList();
  }

//비디오를 리턴하는 메서드
  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videosRepo);

    /*
    //첫번째 page를 원한다는 걸 의미함 우리가 넘겨받은 페이지가 없을 때 이 메서드를 build 메서드에서 호출함
    final result = await _repository.fetchVideos(lastItemCreatedAt: null);
    //map은 새로운 것을 생성함
    //result에 있는 모든 documents 대해서 (video) => 1 함수들을 실행함 ==> 리스트에 모두 1이 들어감
    //무엇을 리턴하든지 newList에 넣을 거다
    final newList = result.docs.map(
      // => 는 임시적 반환을 해준다 {} 를 사용할 경우에는 아무것도 반환하지 않
      (doc) => VideoModel.fromJson(
        doc.data(),
      ),
    );
    */
    _list = await _fetchVideos(lastItemCreatedAt: null);

    return _list;
  }

  Future<void> fetchNextPage() async {
    //데이터에 실제로 뭘 해줄지 선택할수 있다???
    final nextPage =
        await _fetchVideos(lastItemCreatedAt: _list.last.createdAt);
    //모든 데이터가 도착했을때 state를 새로운 state로 교체한다
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> refresh() async {
    //새로고침할때 현재 페이지에 대해서는 신경쓰지 않는다.
    final videos = await _fetchVideos(lastItemCreatedAt: null);
    _list = videos;
    //새로고침할때 state를 교체하고 싶
    state = AsyncData(videos);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
