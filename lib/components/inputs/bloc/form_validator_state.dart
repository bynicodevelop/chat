part of 'form_validator_bloc.dart';

// ignore: must_be_immutable
class FormValidatorState extends Equatable {
  List<dynamic> inputs;
  bool isValid;
  bool isSubmitted;

  FormValidatorState({
    required this.inputs,
    this.isValid = false,
    this.isSubmitted = false,
  });

  @override
  List<Object> get props => [
        inputs,
        isValid,
        isSubmitted,
      ];
}
