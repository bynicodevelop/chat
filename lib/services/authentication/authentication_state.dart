part of 'authentication_bloc.dart';

enum UnAuthenticatedStatus {
  unauthenticated,
  logout,
  invalidEmail,
  invalidPassword,
  emailAlreadyExists,
  badCredentials,
  affiliateIdNotFound,
  passwordReset,
  unexpected,
}

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class UnAuthenticatedState extends AuthenticationState {
  final UnAuthenticatedStatus unAuthenticatedStatus;

  UnAuthenticatedState({
    this.unAuthenticatedStatus = UnAuthenticatedStatus.unauthenticated,
  });
}

class AuthenticatedState extends AuthenticationState {}
