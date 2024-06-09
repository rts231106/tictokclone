import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tictokclone/constants/gaps.dart';
import 'package:tictokclone/constants/sizes.dart';
import 'package:tictokclone/feature/main_navigation/main_navigation_screen.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Page _showingPage = Page.first;
  Direction direction = Direction.right;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        direction = Direction.right;
      });
    } else {
      setState(() {
        direction = Direction.left;
      });
    }
  }

  void onPanEnd(DragEndDetails detail) {
    if (direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

void _onEnterAppTap(){ 
   Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>  MainNavigationScreen(),
          ),
          (route) {
            print(route);
            return false;
          },
        );
}
  @override
  Widget build(BuildContext context) {
    //페이지가 몇개인지 설정해야 함 tabBarView의 padding 개수를 의미
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v56,
                  Text(
                    "Follow the rules",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ],
              ),
              secondChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v56,
                  Text(
                    "Enjoy the ride",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "take care of one another Plis!",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ],
              ),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(microseconds: 200),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size14,
            horizontal: Sizes.size2,
          ),
          child: AnimatedOpacity(
            duration: const Duration(
              milliseconds: 200,
            ),
            opacity: _showingPage == Page.first ? 0 : 1,
            child: CupertinoButton(
              color: Theme.of(context).primaryColor,
              onPressed: _onEnterAppTap,
              child: const Text("Enter the app!"),
            ),
          ),
        ),
      ),
    );
  }
}
