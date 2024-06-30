import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictokclone/constants/gaps.dart';
import 'package:tictokclone/constants/sizes.dart';
import 'package:tictokclone/feature/setting/settings_screen.dart';
import 'package:tictokclone/feature/users/widgets/persistentTabBar.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen(
      {super.key, required this.username, required this.tab});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onSettingTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SettingsScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: widget.tab == "likes" ? 1 : 0,
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  centerTitle: true,
                  title: Text(
                    widget.username,
                  ),
                  actions: [
                    IconButton(
                      onPressed: _onSettingTap,
                      icon: const FaIcon(
                        FontAwesomeIcons.gear,
                        size: Sizes.size20,
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Gaps.v20,
                      CircleAvatar(
                        radius: 30,
                        foregroundColor: Colors.red,
                        child: Text(
                          widget.username,
                        ),
                      ),
                      Gaps.v20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@${widget.username}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size16,
                            ),
                          ),
                          Gaps.h5,
                          const FaIcon(
                            FontAwesomeIcons.circleCheck,
                            size: Sizes.size16,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      Gaps.v20,
                      SizedBox(
                        height: Sizes.size48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Column(
                              children: [
                                Text(
                                  "97",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Sizes.size16,
                                  ),
                                ),
                                Gaps.v2,
                                Text(
                                  "Following",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            VerticalDivider(
                              width: Sizes.size32,
                              thickness: Sizes.size1,
                              color: Colors.grey.shade400,
                              indent: Sizes.size14,
                              endIndent: Sizes.size14,
                            ),
                            const Column(
                              children: [
                                Text(
                                  "10.5M",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Sizes.size16,
                                  ),
                                ),
                                Gaps.v2,
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            VerticalDivider(
                              width: Sizes.size32,
                              thickness: Sizes.size1,
                              color: Colors.grey.shade400,
                              indent: Sizes.size14,
                              endIndent: Sizes.size14,
                            ),
                            const Column(
                              children: [
                                Text(
                                  "149.3M",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Sizes.size16,
                                  ),
                                ),
                                Gaps.v2,
                                Text(
                                  "Likes",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gaps.v14,
                      FractionallySizedBox(
                        widthFactor: 0.33,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size12,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(
                              Sizes.size4,
                            ),
                          ),
                          child: const Text(
                            "Follow",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Gaps.v14,
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.size32,
                        ),
                        child: Text(
                          "all highlights and where to watch live matches on FIFA+ i wonder",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gaps.v14,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.link,
                            size: Sizes.size12,
                          ),
                          Gaps.h4,
                          Text(
                            "https:..nomadcoders.co",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v5,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.zero,
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: Sizes.size2,
                    mainAxisSpacing: Sizes.size2,
                    //비율
                    childAspectRatio: 9 / 14,
                  ),
                  itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        child: AspectRatio(
                          aspectRatio: 9 / 14,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "lib/assets/images/cat.png",
                            image:
                                "https://plus.unsplash.com/premium_photo-1715071976245-b4ab72b6c48b?q=80&w=2188&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          ),
                        ),
                      ),
                      //모든 textstyle이 적용된다
                    ],
                  ),
                ),
                const Center(
                  child: Text("data2"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
