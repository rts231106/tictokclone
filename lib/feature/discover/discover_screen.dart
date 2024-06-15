import 'package:flutter/material.dart';
import 'package:tictokclone/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          surfaceTintColor: Colors.white,
          title: const Text("Discover"),
          //bottom은 자식요소의 크기를 제한하지 않는 위젯 preferred widget 개념 화인하기 바로 Container는 사용 하지 못한다
          //Tap controller 가 필요
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (var tab in tabs)
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}