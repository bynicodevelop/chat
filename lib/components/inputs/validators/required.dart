import 'package:chat/components/inputs/validators/input_state.dart';
import 'package:formz/formz.dart';

class Required extends FormzInput<String, InputState> {
  const Required.pure([String value = '']) : super.pure(value);

  const Required.dirty([String value = '']) : super.dirty(value);

  @override
  InputState? validator(String? value) {
    if (value!.isEmpty == true) {
      return InputState.empty;
    }

    return null;
  }
}
