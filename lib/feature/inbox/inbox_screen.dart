import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictokclone/constants/sizes.dart';
import 'package:tictokclone/feature/inbox/activity_scree.dart';
import 'package:tictokclone/feature/inbox/chats_screen.dart';

class InBoxScreen extends StatelessWidget {
  const InBoxScreen({super.key});

  void _onDmPressed(BuildContext context) {

        Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChatScreen(),
      ),
    );
  }

  
  void _onActivityTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ActivityScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 1,
        title: const Text('inbox'),
        actions: [
          IconButton(
            onPressed: () => _onDmPressed(context),
            icon: const FaIcon(
              FontAwesomeIcons.paperPlane,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // 다양한 기능이 있음 Text 해보기
          ListTile(
            onTap: () => _onActivityTap(context),
            title: const Text(
              "Activity",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.black,
            ),
          ),
          Container(
            height: Sizes.size1,
            color: Colors.grey.shade200,
          ),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              "New folloowers",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.black,
            ),
            subtitle: const Text(
              "Message from followers will appear here",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
