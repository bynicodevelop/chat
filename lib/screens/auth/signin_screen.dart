import 'package:chat/components/inputs/input_button.dart';
import 'package:chat/components/inputs/input_email.dart';
import 'package:chat/components/inputs/input_form.dart';
import 'package:chat/components/inputs/input_password.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/responsive.dart';
import 'package:chat/screens/auth/forgotten_screen.dart';
import 'package:chat/screens/auth/signup_screen.dart';
import 'package:chat/services/authentication/authentication_bloc.dart';
import 'package:chat/transitions/no_animation_material_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  String _message(UnAuthenticatedStatus unAuthenticatedStatus) {
    switch (unAuthenticatedStatus) {
      case UnAuthenticatedStatus.invalidEmail:
        return "Invalid email";
      case UnAuthenticatedStatus.invalidPassword:
        return "Invalid password";
      case UnAuthenticatedStatus.badCredentials:
        return "Bad credentials";
      case UnAuthenticatedStatus.unexpected:
        return "Service temporarily unavailable";
      default:
        return "";
    }
  }

  bool _isVisible(state) =>
      state is UnAuthenticatedState &&
      (state.unAuthenticatedStatus != UnAuthenticatedStatus.unauthenticated &&
          state.unAuthenticatedStatus != UnAuthenticatedStatus.logout);

  Widget _wrapper(
    BuildContext context,
    double horizontalPadding,
    void Function(dynamic) onSubmitted,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Me connecter",
              style: Theme.of(context).textTheme.headline1,
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is UnAuthenticatedState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: _isVisible(state),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding / 2,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: kDefaultPadding / 2,
                            ),
                            decoration: BoxDecoration(
                              color: kErrorColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(kDefaultPadding / 2),
                              ),
                            ),
                            child: Text(
                              _message(state.unAuthenticatedStatus),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      _form(onSubmitted),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              NoAnimationMaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            ),
                            child: Text("Créer un compte"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              NoAnimationMaterialPageRoute(
                                builder: (context) => ForgotterScreen(),
                              ),
                            ),
                            child: Text("Mot de passe oublié ?"),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return SizedBox.shrink();
              },
            )
          ],
        ),
      );

  InputForm _form(void Function(dynamic) onSubmitted) => InputForm(
        children: [
          InputEmail(placeholder: "Enter your email"),
          InputPassword(placeholder: "Enter your password"),
          InputButton(label: "Se connecter")
        ],
        onSubmitted: onSubmitted,
      );

  void _sendSignEvent(BuildContext context, dynamic values) =>
      context.read<AuthenticationBloc>().add(
            AuthenticationSignInEvent(
              email: values.firstWhere(
                  (value) => value["fieldName"] == "email")["value"],
              password: values.firstWhere(
                  (value) => value["fieldName"] == "password")["value"],
            ),
          );

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Scaffold(
        body: _wrapper(
          context,
          20.0,
          (values) => _sendSignEvent(context, values),
        ),
      ),
      tablet: Scaffold(
          body: _wrapper(
        context,
        (MediaQuery.of(context).size.width - 400) / 2,
        (values) => _sendSignEvent(context, values),
      )),
      desktop: Scaffold(
        body: _wrapper(
          context,
          (MediaQuery.of(context).size.width - 400) / 2,
          (values) => _sendSignEvent(context, values),
        ),
      ),
    );
  }
}
