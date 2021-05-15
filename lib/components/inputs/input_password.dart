import 'package:chat/components/inputs/bloc/form_validator_bloc.dart';
import 'package:chat/components/inputs/input.dart';
import 'package:chat/components/inputs/input_abstract.dart';
import 'package:chat/components/inputs/validators/required.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputPassword extends StatefulWidget implements InputAbstract {
  final String placeholder;

  @override
  FormzInput? get validator => Required.dirty();

  @override
  String get fieldName => "password";

  InputPassword({
    Key? key,
    required this.placeholder,
  }) : super(key: key);

  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _isSecret = true;

  @override
  Widget build(BuildContext context) {
    return Input(
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
      obscureText: _isSecret,
      errorText: context.watch<FormValidatorBloc>().state.isSubmitted &&
              context.watch<FormValidatorBloc>().state.inputs.firstWhere(
                          (input) => input["fieldName"] == widget.fieldName)[
                      "validator"] !=
                  null
          ? "Entrez un mot de passe de plus de 6 caractères"
          : null,
      suffixIcon: InkWell(
        onTap: () => setState(() => _isSecret = !_isSecret),
        child: Icon(
          _isSecret ? Icons.visibility : Icons.visibility_off,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
