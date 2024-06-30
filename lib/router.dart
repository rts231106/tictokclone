import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictokclone/feature/authentication/email_screen.dart';
import 'package:tictokclone/feature/authentication/login_screen.dart';
import 'package:tictokclone/feature/authentication/repos/authentication_repo.dart';
import 'package:tictokclone/feature/authentication/sign_up_screen.dart';
import 'package:tictokclone/feature/authentication/username_screen.dart';
import 'package:tictokclone/feature/main_navigation/main_navigation_screen.dart';
import 'package:tictokclone/feature/users/user_profile_screen.dart';
import 'package:tictokclone/feature/videos/view_models/timeline_view_model.dart';

final routerProvider = Provider(
  (ref) {
    ref.read(authRepo);
    return GoRouter(
      initialLocation: "/",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LogInScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
        return null;
      },
      routes: [
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeURL,
          builder: (context, state) => const SignUpScreen(),
          routes: [
            GoRoute(
              path: UsernameScreen.routeURL,
              name: UsernameScreen.routeName,
              builder: (context, state) => const UsernameScreen(),
            ),
          ],
        ),
        /*GoRoute(
        path: "/:tab(home|discover|inbox|profile)",
        name: MainNavigationScreen.routeName,
        builder: (context, state) {
          final tab = state.params["tab"]!;
          return MainNavigationScreen(tab: tab);*/
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
        ),
      ],
    );
  },
);
