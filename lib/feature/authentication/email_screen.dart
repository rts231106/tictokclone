import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictokclone/constants/gaps.dart';
import 'package:tictokclone/constants/sizes.dart';
import 'package:tictokclone/feature/authentication/password_screen.dart';
import 'package:tictokclone/feature/authentication/view_models/signup_view_models.dart';
import 'package:tictokclone/feature/authentication/widget/form_button.dart';

class EmailScreenArgs {
  final String username;
  EmailScreenArgs({required this.username});
}

class EmailScreen extends ConsumerStatefulWidget {


  final String username;
  const EmailScreen({super.key, required this.username});

  @override
  EmailScreenState createState() => EmailScreenState();
}

class EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return " Not valid";
    }
    return null;
  }

//텍스트 상자 바깥을 선택할때 감지하는 메서드
  void _onScaffordTap() {
    FocusScope.of(context).unfocus();
  }

  //next를 누르거나 키보드 done 누를때 다음 화면으로 넘어가는 메서드
  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    
    ref.read(signUpform.notifier).state = {"email": _email};

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffordTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              Text(
                "What is your email, ${widget.username}?",
                style: const TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                //키보드 타입 정하
                keyboardType: TextInputType.emailAddress,
                //자동완성
                autocorrect: false,
                // onSubmitted , onEditingComplete 차이점 확인하기
                onEditingComplete: _onSubmit,
                controller: _emailController,
                decoration: InputDecoration(
                  //텍스트 박스를 클릭안했을때
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  //텍스트 박스를 클릭할때
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  hintText: "Email",
                  errorText: _isEmailValid(),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v16,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: _email.isEmpty || _isEmailValid() != null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
