import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tictokclone/feature/videos/view_models/timeline_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _savedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(
        widget.video.path,
      ),
    );

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  Future convertTempFileToVideo(String tempFilePath) async {
    final tempFile = File(tempFilePath);
    final fileContent = await tempFile.readAsBytes();

// 기존 파일 경로의 확장자 교체
    final newFilePath = tempFilePath.replaceFirst('.temp', '.mp4');

    final newFile = File(newFilePath);
    await newFile.writeAsBytes(fileContent);
    return newFilePath;
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) return;

    String newFilePath;

// 파일 경로가 .temp로 끝나는지 확인
    if (widget.video.path.endsWith(".temp")) {
// 임시 파일을 비디오 파일로 변환
      newFilePath = await convertTempFileToVideo(widget.video.path);
    } else {
// 변환할 필요가 없는 경우
      newFilePath = widget.video.path;
    }

// 갤러리에 저장
    final result =
        await GallerySaver.saveVideo(newFilePath, albumName: "Tictok_Clone");

    if (result == true) {
      _savedVideo = true;
      setState(() {});
    }
  }

  void _onUploadPressed() {
    ref.read(timelineProvider.notifier).uploadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("preview"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(
                _savedVideo
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.download,
              ),
            ),
          IconButton(
            onPressed: ref.watch(timelineProvider).isLoading
                ? () {}
                : _onUploadPressed,
            icon: ref.watch(timelineProvider).isLoading
                ? const CircularProgressIndicator()
                : const FaIcon(FontAwesomeIcons.cloudArrowUp),
          ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
