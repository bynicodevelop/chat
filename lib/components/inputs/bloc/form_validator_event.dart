part of 'form_validator_bloc.dart';

abstract class FormValidatorEvent extends Equatable {
  const FormValidatorEvent();

  @override
  List<Object> get props => [];
}

class FormValidatorInitializeEvent extends FormValidatorEvent {
  final List<Map<String, dynamic>> inputs;

  FormValidatorInitializeEvent({
    required this.inputs,
  });
}

class FormValidatorSubmitted extends FormValidatorEvent {}

class FormValidatorInputUpdated extends FormValidatorEvent {
  final Map<String, dynamic> inputModel;

  FormValidatorInputUpdated(this.inputModel);
}
