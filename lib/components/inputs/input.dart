import 'package:chat/config/constants.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final void Function(String)? onChanged;
  final String initialValue;

  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? errorText;

  Input({
    Key? key,
    required this.placeholder,
    required this.onChanged,
    this.initialValue = "",
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
      ),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: placeholder,
          suffixIcon: suffixIcon,
          errorText: errorText,
          errorMaxLines: 2,
        ),
      ),
    );
  }
}
