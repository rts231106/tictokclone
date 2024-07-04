import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictokclone/feature/authentication/repos/authentication_repo.dart';
import 'package:tictokclone/feature/users/view_models/users_view_model.dart';
import 'package:tictokclone/feature/videos/models/video_model.dart';
import 'package:tictokclone/feature/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;

    if (userProfile != null) {
      state = const AsyncValue.loading();

      state = await AsyncValue.guard(() async {
        try {
          final task = await _repository.uploadVideoFile(
            video,
            user!.uid,
          );

          if (task.metadata != null) {
            await _repository.saveVideo(
              VideoModel(
                title: "From Flutter!",
                description: "Hell yeah!",
                fileUrl: await task.ref.getDownloadURL(),
                thumbnailUrl: "",
                creatorUid: user.uid,
                likes: 0,
                comments: 0,
                createdAt: DateTime.now().millisecondsSinceEpoch,
                creator: userProfile.name,
              ),
            );

            context.pop();

            context.pop();
          }
        } catch (e) {
          // Firestore 예외 처리
          print('Firestore 오류: $e');

          // 재시도 로직 추가
          await Future.delayed(const Duration(seconds: 5)); // 5초 후에 재시도
        }
      });
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
