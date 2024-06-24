import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictokclone/feature/authentication/email_screen.dart';
import 'package:tictokclone/feature/authentication/login_screen.dart';
import 'package:tictokclone/feature/authentication/sign_up_screen.dart';
import 'package:tictokclone/feature/authentication/username_screen.dart';
import 'package:tictokclone/feature/users/user_profile_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    name: SignUpScreen.routeName,
    path: SignUpScreen.routeURL,
    builder: (context, state) => const SignUpScreen(),
    routes: [
      GoRoute(
        path: UsernameScreen.routeURL,
        name: UsernameScreen.routeName,
        builder: (context, state) => const UsernameScreen(),
        routes: [
          GoRoute(
            name: EmailScreen.routeName,
              path: EmailScreen.routeURL,
              builder: (context, state) {
                final args = state.extra as EmailScreenArgs;
                return EmailScreen(username: args.username);
            },
          ),
        ],
      ),
    ],
  ),
  /*GoRoute(
    path: LogInScreen.routeName,
    builder: (context, state) => const LogInScreen(),
  ),*/
  /*GoRoute(
    name: "username_screen",
    path: UsernameScreen.routeName,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const UsernameScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
      );
    },
    builder: (context, state) => const UsernameScreen(),
  ),*/

  GoRoute(
    path: "/users/:username",
    builder: (context, state) {
      final username = state.params['username'];
      final tab = state.queryParams["show"];
      return UserProfileScreen(username: username!, tab: tab!);
    },
  )
]);
