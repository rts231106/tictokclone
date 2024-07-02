import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictokclone/feature/authentication/repos/authentication_repo.dart';
import 'package:tictokclone/feature/videos/models/video_model.dart';
import 'package:tictokclone/feature/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

//내가 업로드할 파일
  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final task = await _repository.uploadVideoFile(
          video,
          user!.uid,
        );
        //데이터 베이스에 저장
        if (task.metadata != null) {
          await _repository.saveVideo(
            VideoModel(
              fileUrl: await task.ref.getDownloadURL,
              thumbnailUrl: "",
              likes: 0,
              comments: 0,
              creatorUid: user.uid,
              createdAt: DateTime.now().microsecondsSinceEpoch,
              title: "From Flutter",
              description: "hell",
              creator: user.uid,
            ),
          );
          //위 2개가 모두 잘 작동 된다
          context.go("/home");
        }
      },
    );
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
