import 'package:flutter/material.dart';
import 'package:tictokclone/constants/sizes.dart';
import 'package:tictokclone/feature/authentication/sign_up_screen.dart';
import 'package:tictokclone/feature/main_navigation/main_navigation_screen.dart';
import 'package:tictokclone/feature/onboarding/interests_screen.dart';

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
      theme: ThemeData(
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
        primaryColor: const Color(0xFFe9435A),
      ),
      home: const MainNavigationScreen(),
    );
  }
}
