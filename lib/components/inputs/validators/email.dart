import 'package:chat/components/inputs/validators/input_state.dart';
import 'package:formz/formz.dart';

class Email extends FormzInput<String, InputState> {
  const Email.pure([String value = '']) : super.pure(value);

  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  InputState? validator(String? value) {
    if (value!.isEmpty == true) {
      return InputState.empty;
    }

    if (!_emailRegExp.hasMatch(value)) {
      return InputState.invalidEmail;
    }

    return null;
  }
}
