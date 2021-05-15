import 'package:chat/components/inputs/bloc/form_validator_bloc.dart';
import 'package:chat/components/inputs/input.dart';
import 'package:chat/components/inputs/input_abstract.dart';
import 'package:chat/components/inputs/validators/required.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class InputUsername extends StatefulWidget implements InputAbstract {
  final String placeholder;

  @override
  FormzInput? get validator => Required.dirty();

  @override
  String get fieldName => "username";

  String initialValue;

  InputUsername({
    Key? key,
    required this.placeholder,
    this.initialValue = "",
  }) : super(key: key);

  @override
  _InputUsernameState createState() => _InputUsernameState();
}

class _InputUsernameState extends State<InputUsername> {
  @override
  void initState() {
    super.initState();

    context.read<FormValidatorBloc>().add(
          FormValidatorInputUpdated(
            {
              "fieldName": widget.fieldName,
              "validator": widget.validator!.validator(widget.initialValue),
              "value": widget.initialValue,
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Input(
      initialValue: widget.initialValue,
      onChanged: (value) => context.read<FormValidatorBloc>().add(
            FormValidatorInputUpdated(
              {
                "fieldName": widget.fieldName,
                "validator": widget.validator!.validator(value),
                "value": value,
              },
            ),
          ),
      placeholder: widget.placeholder,
      keyboardType: TextInputType.emailAddress,
      errorText: context.watch<FormValidatorBloc>().state.isSubmitted &&
              context.watch<FormValidatorBloc>().state.inputs.firstWhere(
                          (input) => input["fieldName"] == widget.fieldName)[
                      "validator"] !=
                  null
          ? "Entrez un nom d'utilisateur"
          : null,
    );
  }
}
