import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictokclone/feature/authentication/repos/authentication_repo.dart';

class SignUpviewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp() async {
    state = AsyncValue.loading();
    _authRepo = ref.read(authRepo);
    final form = ref.read(signUpform);
    state = await AsyncValue.guard(
        () async => _authRepo.signUp(form["email"], form["password"]));
  }
}

final signUpform = StateProvider((ref) => {});
final signUpProvider = AsyncNotifierProvider<SignUpviewModel, void>(
  () => SignUpviewModel(),
);
