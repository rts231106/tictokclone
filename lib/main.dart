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
        brightness: Brightness.light,
        textTheme: TextTheme(
          //copywith(color : Colors.red) 이런식으로 사용할 수 있음 특별한 텍스트 
          displayLarge: GoogleFonts.openSans(
              fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          displayMedium: GoogleFonts.openSans(
              fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          displaySmall:
              GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
          headlineMedium: GoogleFonts.openSans(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headlineSmall:
              GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
          titleLarge: GoogleFonts.openSans(
              fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          titleMedium: GoogleFonts.openSans(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          titleSmall: GoogleFonts.openSans(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyLarge: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyMedium: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          labelLarge: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
          bodySmall: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          labelSmall: GoogleFonts.roboto(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
        ),
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
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFFe9435A),
          brightness: Brightness.dark,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          )),
      home: const SignUpScreen(),
    );
  }
}
