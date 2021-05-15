import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'form_validator_event.dart';
part 'form_validator_state.dart';

class FormValidatorBloc extends Bloc<FormValidatorEvent, FormValidatorState> {
  FormValidatorBloc()
      : super(FormValidatorState(inputs: <Map<String, dynamic>>[]));

  @override
  Stream<FormValidatorState> mapEventToState(
    FormValidatorEvent event,
  ) async* {
    if (event is FormValidatorInitializeEvent) {
      yield FormValidatorState(
        inputs: event.inputs,
      );
    } else if (event is FormValidatorInputUpdated) {
      dynamic input = event.inputModel;

      int index = state.inputs
          .indexWhere((element) => element["fieldName"] == input["fieldName"]);

      List<dynamic> inputs = List<dynamic>.from(state.inputs);

      inputs[index] = input;

      List<dynamic> errors =
          inputs.where((element) => element["validator"] != null).toList();

      yield FormValidatorState(
        inputs: inputs,
        isValid: errors.length == 0,
      );
    } else if (event is FormValidatorSubmitted) {
      yield FormValidatorState(
        inputs: state.inputs,
        isValid: state.isValid,
        isSubmitted: true,
      );
    }
  }
}
