part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationInitializeEvent extends AuthenticationEvent {}

class AuthenticationSignInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationSignInEvent({
    required this.email,
    required this.password,
  });
}

class AuthenticationSignUpEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String affiliateId;

  AuthenticationSignUpEvent({
    required this.email,
    required this.password,
    required this.affiliateId,
  });
}

class AuthenticationResetPasswordEvent extends AuthenticationEvent {
  final String email;

  AuthenticationResetPasswordEvent({
    required this.email,
  });
}

class AuthenticationLogoutEvent extends AuthenticationEvent {}
