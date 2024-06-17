import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictokclone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //slivers  scroll view의 일부 scroll할때 사용하는것
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.teal,
          title: const Text("data"),
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
              StretchMode.zoomBackground,
            ],
            background: Image.asset(
              "lib/assets/images/cat.png",
              fit: BoxFit.cover,
            ),
            title: const Text("data"),
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.teal[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  ":dsaldkj $index",
                ),
              ),
            ),
          ),
          //item 크기
          itemExtent: 100,
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: 20,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  ":dsaldkj",
                ),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing: Sizes.size20,
            crossAxisSpacing: Sizes.size20,
            childAspectRatio: 1,
          ),
        ),
      ],
    );
  }
}
