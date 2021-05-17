part of 'authentication_bloc.dart';

enum UnAuthenticatedStatus {
  none,
  authenticated,
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

  @override
  List<Object> get props => [unAuthenticatedStatus];
}

class AuthenticatedState extends AuthenticationState {
  final UnAuthenticatedStatus unAuthenticatedStatus;

  AuthenticatedState({
    this.unAuthenticatedStatus = UnAuthenticatedStatus.none,
  });

  @override
  List<Object> get props => [unAuthenticatedStatus];
}
