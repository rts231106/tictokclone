import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictokclone/feature/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //업로드 비디오 파일, 유저 아이디마다 파일을 만들기 위해 uid를 받

  uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
          "/videos/$uid/${DateTime.now().microsecondsSinceEpoch.toString()}",
        );
    return fileRef.putFile(video);
  }

  //비디오 문서 생성
  Future<void> saveVideo(VideoModel data) async {
    await _db.collection("videos").add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos(
    {int? lastItemCreatedAt}
  ) {
    //페이지 1에서 비디오를 가져오는 코드 
    final query = _db
        .collection("videos")
        .orderBy(
          "createdAt",
          descending: true,
        )
        //2개까지만 리미트 한다
        .limit(2);
    if (lastItemCreatedAt == null) {
      return query
          //여기 리스트는 orderby가 된 모든 것들의 필드임
          .get();
    } else {
     //다른 페이지에서 가져오는 비디오 
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }
}

final videosRepo = Provider((ref) => VideosRepository());
