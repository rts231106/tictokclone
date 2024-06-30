import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictokclone/constants/gaps.dart';
import 'package:tictokclone/constants/sizes.dart';
import 'package:tictokclone/feature/discover/discover_screen.dart';
import 'package:tictokclone/feature/inbox/inbox_screen.dart';
import 'package:tictokclone/feature/main_navigation/widget/nav_tap.dart';
import 'package:tictokclone/feature/main_navigation/widget/post_video_button.dart';
import 'package:tictokclone/feature/users/user_profile_screen.dart';
import 'package:tictokclone/feature/utils.dart';
import 'package:tictokclone/feature/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 4;

//navigation일은 navigaion screen에서 처리를 해야함 button 위젯에서 처리하는건 좋지않
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => Scaffold(
                appBar: AppBar(
                  title: const Text("Record video"),
                ),
              ),
          //fullscreen으로 만들겠다.
          fullscreenDialog: true),
    );
  }

  void _onCommentsTap(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => Container());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Scaffold(
      //댓글에서 키보드가 나왔을때 안찌그러지도록 하는 것
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          //navigaionbar에서 탭 이동후 다시 돌아왔을때 화면이 초기화되는것이 아니라 고객이 본 그 view를 그대로 볼수 있도록
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InBoxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "dong",
              tab: "",
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor:
            _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
        color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              selectedIndex: _selectedIndex,
              text: "Home",
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              isSelecte: _selectedIndex == 0,
              onTap: () => _onTap(0),
            ),
            NavTab(
              selectedIndex: _selectedIndex,
              text: "Discover",
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              isSelecte: _selectedIndex == 1,
              onTap: () => _onTap(1),
            ),
            GestureDetector(
              onTap: _onPostVideoButton,
              child: PostVideoButton(inverted: _selectedIndex != 0),
            ),
            NavTab(
              text: "Inbox",
              icon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              isSelecte: _selectedIndex == 3,
              onTap: () => _onTap(3),
              selectedIndex: _selectedIndex,
            ),
            NavTab(
              text: "Profile",
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              isSelecte: _selectedIndex == 4,
              onTap: () => _onTap(4),
              selectedIndex: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
