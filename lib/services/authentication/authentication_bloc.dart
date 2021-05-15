import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/abstracts/authentication.dart';
import 'package:chat/repositories/exceptions/affiliate_id_not_found.dart';
import 'package:chat/repositories/exceptions/email_already_exists_exception.dart';
import 'package:chat/repositories/exceptions/invalid_email_exception.dart';
import 'package:chat/repositories/exceptions/invalid_password_exception.dart';
import 'package:chat/repositories/exceptions/unexpected_exception.dart';
import 'package:chat/repositories/exceptions/wrong_password_exception.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  AuthenticationBloc(
    this._authenticationRepository,
  ) : super(AuthenticationInitialState());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationInitializeEvent) {
      final bool isAuthenticated = _authenticationRepository.isAuthenticated;

      if (isAuthenticated) {
        yield AuthenticatedState();
        return;
      }

      yield UnAuthenticatedState();
    } else if (event is AuthenticationSignInEvent) {
      yield AuthenticationInitialState();

      try {
        await _authenticationRepository.signin(
          event.email,
          event.password,
        );
      } on InvalidEmailException {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.invalidEmail,
        );

        return;
      } on WrongPasswordException {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.badCredentials,
        );

        return;
      } on UnexpectedException {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.unexpected,
        );

        return;
      }

      yield AuthenticatedState();
    } else if (event is AuthenticationSignUpEvent) {
      yield AuthenticationInitialState();

      try {
        await _authenticationRepository.signup(
          event.email,
          event.password,
          event.affiliateId,
        );
      } on EmailAlreadyExistsException {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.emailAlreadyExists,
        );

        return;
      } on InvalidEmailException {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.invalidEmail,
        );

        return;
      } on InvalidPasswordException {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.invalidPassword,
        );

        return;
      } on WrongPasswordException {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.badCredentials,
        );

        return;
      } on AffiliateIdNotFound {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.affiliateIdNotFound,
        );

        return;
      } on UnexpectedException {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.unexpected,
        );

        return;
      }

      yield AuthenticatedState();
    } else if (event is AuthenticationResetPasswordEvent) {
      yield AuthenticationInitialState();

      try {
        await _authenticationRepository.resetPassword(event.email);

        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.passwordReset,
        );

        return;
      } on InvalidEmailException {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.invalidEmail,
        );

        return;
      } on UnexpectedException {
        yield UnAuthenticatedState(
          unAuthenticatedStatus: UnAuthenticatedStatus.unexpected,
        );

        return;
      }
    } else if (event is AuthenticationLogoutEvent) {
      await _authenticationRepository.logout();

      yield UnAuthenticatedState(
        unAuthenticatedStatus: UnAuthenticatedStatus.logout,
      );
    }
  }
}
