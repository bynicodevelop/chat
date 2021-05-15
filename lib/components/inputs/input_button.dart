import 'package:chat/components/inputs/bloc/form_validator_bloc.dart';
import 'package:chat/components/inputs/input_abstract.dart';
import 'package:chat/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class InputButton extends StatelessWidget implements InputAbstract {
  final String label;

  @override
  FormzInput? get validator => null;

  @override
  String get fieldName => "button";

  const InputButton({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainButton(
      label: label,
      onSubmitted: () => context.read<FormValidatorBloc>().add(
            FormValidatorSubmitted(),
          ),
    );
  }
}
