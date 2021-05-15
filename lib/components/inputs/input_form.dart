import 'package:chat/components/inputs/bloc/form_validator_bloc.dart';
import 'package:chat/components/inputs/input_abstract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputForm extends StatelessWidget {
  final List<Widget> children;
  final void Function(dynamic) onSubmitted;

  const InputForm({
    Key? key,
    required this.children,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormValidatorBloc()
        ..add(
          FormValidatorInitializeEvent(
            inputs: children
                .where((child) => (child as InputAbstract).validator != null)
                .map((child) => {
                      "fieldName": (child as InputAbstract).fieldName,
                      "value": "",
                      "validator":
                          (child as InputAbstract).validator!.validator(""),
                    })
                .toList(),
          ),
        ),
      child: BlocConsumer<FormValidatorBloc, FormValidatorState>(
        listener: (context, state) {
          if (state.isValid && state.isSubmitted) {
            onSubmitted(state.inputs);
          }
        },
        builder: (context, state) => Column(
          children: children,
        ),
      ),
    );
  }
}
