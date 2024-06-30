import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictokclone/constants/gaps.dart';
import 'package:tictokclone/constants/sizes.dart';
import 'package:tictokclone/feature/authentication/birthday_screen.dart';
import 'package:tictokclone/feature/authentication/password_screen.dart';
import 'package:tictokclone/feature/authentication/view_models/signup_view_models.dart';
import 'package:tictokclone/feature/authentication/widget/form_button.dart';

class PasswordScreen extends ConsumerStatefulWidget  {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

//패스워드 입력 문자 개수 메서
  bool _ispasswordValid() {
    return _password.isNotEmpty && _password.length >= 8;
  }

//텍스트 상자 바깥을 선택할때 감지하는 메서드
  void _onScaffordTap() {
    FocusScope.of(context).unfocus();
  }

  //next를 누르거나 키보드 done 누를때 다음 화면으로 넘어가는 메서드
  void _onSubmit() {
    if (!_ispasswordValid()) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state,"password": _password};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
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
              const Text(
                "password",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                //비밀번호 * 처럼 보이기
                obscureText: _obscureText,
                //자동완성
                autocorrect: false,
                // onSubmitted , onEditingComplete 차이점 확인하기
                onEditingComplete: _onSubmit,
                controller: _passwordController,
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade300,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade300,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
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
                  )),
                  hintText: "Make it Strong",
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              const Text(
                "Your password must have",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: _ispasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.v5,
                  const Text(" 8 to 20 characters"),
                ],
              ),
              Gaps.v16,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: !_ispasswordValid(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
