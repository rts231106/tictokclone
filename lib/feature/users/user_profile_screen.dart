import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          floating: true,
          stretch: true,
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
            (context, index) => Container(),
          ),
          itemExtent: 100,
        ),
      ],
    );
  }
}
