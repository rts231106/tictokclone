import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictokclone/constants/sizes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Direct Messages",
        ),
        //앱 bar에 +를 넣기 위한 것
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.plus,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              foregroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/3612017"),
              child: Text(
                "dong",
              ),
            ),
            //trailing 을 title과 위쪽으로 위치를 정렬하고 싶음
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "gyoon",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "2:16 pm",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: Sizes.size12,
                  ),
                ),
              ],
            ),
            subtitle: const Text(
              "Don't for get to make video",
            ),
          )
        ],
      ),
    );
  }
}
