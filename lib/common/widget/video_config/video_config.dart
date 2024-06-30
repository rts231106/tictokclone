import 'package:flutter/widgets.dart';

class VideoConfig extends InheritedWidget {
  VideoConfig({required super.child});

  final bool autoMute = false;

  static VideoConfig of( BuildContext context) { 
    return context.dependOnInheritedWidgetOfExactType<VideoConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
