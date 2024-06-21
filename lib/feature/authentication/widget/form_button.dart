import 'package:flutter/material.dart';
import 'package:tictokclone/constants/sizes.dart';
import 'package:tictokclone/feature/utils.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
  });

  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      //비율에 따른 너비 지정
      widthFactor: 1,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:
              disabled 
              ? isDarkMode(context) 
              ? Colors.grey.shade800 
              : Colors.grey.shade100 
              : Theme.of(context).primaryColor,
        ),
        duration: const Duration(
          seconds: 1,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(seconds: 1),
          style: TextStyle(
            color: disabled ? Colors.grey : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: const Text(
            'Next',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
