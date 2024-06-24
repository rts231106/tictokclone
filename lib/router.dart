import 'package:go_router/go_router.dart';
import 'package:tictokclone/feature/authentication/email_screen.dart';
import 'package:tictokclone/feature/authentication/login_screen.dart';
import 'package:tictokclone/feature/authentication/sign_up_screen.dart';
import 'package:tictokclone/feature/authentication/username_screen.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: SignUpScreen.routeName,
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
    path: LogInScreen.routeName,
    builder: (context, state) => const LogInScreen(),
  ),
  GoRoute(
    path: UsernameScreen.routeName,
    builder: (context, state) => const UsernameScreen(),
  ),
  GoRoute(
    path: EmailScreen.routeName,
    builder: (context, state) => const EmailScreen(),
  ),
]);
