import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
    //FirbaseAuth.instance를 해줌으로써 우리는 Firebase와 소통할 수 있다.
  //우리는 main함수 안에서 Firebase initializeApp을 해주었다..
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //getter은 String이든 함수든 blabla.user 이렇게 접근할 수 있도록 해준다.
  //_firebasAuth.currentUser은 현재 접속한(?) User가 있는지 없는지 확인?해준다.
    //만일 접속한 User가 없다면 Null값을 가진다. USer은 Nullable이다.
  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;


  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
  //여기서 우리는 firebase와 통신을 한다. createUserWithEmailAndPassword로 사용자를 생성한다.
  //백엔드로 Create User를 보내는것
  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> githubSignIn() async {
    await _firebaseAuth.signInWithProvider(GithubAuthProvider());
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());

//지금 우리가 하고 있는 것은 유저의 인증상태변경을 감지하는 것이다. 로그인했는지 로그아웃했는지
//Stream은 변화가 생기면 바로 알 수 있다.
final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
