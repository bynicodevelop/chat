import 'package:formz/formz.dart';

abstract class InputAbstract {
  FormzInput? get validator;
  String get fieldName;
}
