import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictokclone/constants/sizes.dart';
import 'package:tictokclone/feature/authentication/sign_up_screen.dart';
import 'package:tictokclone/feature/main_navigation/main_navigation_screen.dart';
import 'package:tictokclone/feature/videos/video_recording_screen.dart';

void main() {
  runApp(const TicTok());
}

class TicTok extends StatelessWidget {
  const TicTok({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        textTheme: Typography.blackMountainView,
        brightness: Brightness.light,

        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFe9435A),
        ),
        //splash 반응이 반영되지 않도록 하는 법(전체적으로)
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade50,
        ),
        primaryColor: const Color(0xFFe9435A),
      ),
      darkTheme: ThemeData(
        textTheme: Typography.whiteMountainView,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFe9435A),
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
      ),
      home: const SignUpScreen(),
    );
  }
}
