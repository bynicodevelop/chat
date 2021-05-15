import 'package:chat/components/inputs/input_affiliate_id.dart';
import 'package:chat/components/inputs/input_button.dart';
import 'package:chat/components/inputs/input_email.dart';
import 'package:chat/components/inputs/input_form.dart';
import 'package:chat/components/inputs/input_password.dart';
import 'package:chat/components/inputs/input_username.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/responsive.dart';
import 'package:chat/screens/auth/forgotten_screen.dart';
import 'package:chat/screens/auth/signin_screen.dart';
import 'package:chat/services/authentication/authentication_bloc.dart';
import 'package:chat/transitions/no_animation_material_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  String _message(UnAuthenticatedStatus unAuthenticatedStatus) {
    switch (unAuthenticatedStatus) {
      case UnAuthenticatedStatus.emailAlreadyExists:
        return "Email already exists";
      case UnAuthenticatedStatus.invalidEmail:
        return "Invalid email";
      case UnAuthenticatedStatus.invalidPassword:
        return "Invalid password";
      case UnAuthenticatedStatus.badCredentials:
        return "Bad credentials";
      case UnAuthenticatedStatus.affiliateIdNotFound:
        return "Your affiliate id not exists";
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
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is UnAuthenticatedState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding,
                        ),
                        child: TextButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            NoAnimationMaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                          label: Text(
                            "Se connecter".toUpperCase(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding,
                        ),
                        child: Container(
                          height: 3.0,
                          width: 100.0,
                          color: kCTAColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding / 2,
                        ),
                        child: Text(
                          "Créer votre compte",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding / 2,
                        ),
                        child: Text(
                          "L'application est en cours de lancement. Vous ne pouvez vous inscrire que si vous avez été invité.",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding / 2,
                        ),
                        child: Text(
                          "Merci de bien vouloir saisir l'id de la personne qui vous à invité.",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
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
                                builder: (context) => SignInScreen(),
                              ),
                            ),
                            child: Text("Se connecter"),
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
          InputAffiliateId(placeholder: "Enter your affiliate Id"),
          InputEmail(placeholder: "Enter your email"),
          InputPassword(placeholder: "Enter your password"),
          InputButton(label: "Créer mon compte"),
        ],
        onSubmitted: onSubmitted,
      );

  void _sendSignEvent(BuildContext context, dynamic values) =>
      context.read<AuthenticationBloc>().add(
            AuthenticationSignUpEvent(
              email: values.firstWhere(
                  (value) => value["fieldName"] == "email")["value"],
              password: values.firstWhere(
                  (value) => value["fieldName"] == "password")["value"],
              affiliateId: values.firstWhere(
                  (value) => value["fieldName"] == "affiliateId")["value"],
            ),
          );

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: _wrapper(
              context,
              20.0,
              (values) => _sendSignEvent(context, values),
            ),
          ),
        ),
      ),
      tablet: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: _wrapper(
              context,
              (MediaQuery.of(context).size.width - 400) / 2,
              (values) => _sendSignEvent(context, values),
            ),
          ),
        ),
      ),
      desktop: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: _wrapper(
              context,
              (MediaQuery.of(context).size.width - 400) / 2,
              (values) => _sendSignEvent(context, values),
            ),
          ),
        ),
      ),
    );
  }
}
