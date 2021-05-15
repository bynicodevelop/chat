import 'package:chat/components/inputs/bloc/form_validator_bloc.dart';
import 'package:chat/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainButton extends StatelessWidget {
  final String label;
  final void Function() onSubmitted;

  const MainButton({
    Key? key,
    required this.label,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: ElevatedButton(
          onPressed: context.watch<FormValidatorBloc>().state.isValid
              ? onSubmitted
              : null,
          child: Text(
            label,
            style: TextStyle(
              fontSize: kDefaultFontSize * 1.2,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
