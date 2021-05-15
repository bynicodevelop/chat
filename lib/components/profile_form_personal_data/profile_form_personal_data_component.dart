import 'package:chat/components/inputs/input_button.dart';
import 'package:chat/components/inputs/input_email.dart';
import 'package:chat/components/inputs/input_form.dart';
import 'package:chat/components/inputs/input_username.dart';
import 'package:chat/components/profile_display_name/bloc/profile_display_name_bloc.dart';
import 'package:chat/components/profile_form_personal_data/bloc/profile_form_personal_data_bloc.dart';
import 'package:chat/components/profile_update_image/profile_update_image_component.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/repositories/models/profile_model.dart';
import 'package:chat/services/authentication/authentication_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_platform/universal_platform.dart';

class ProfileFormPersonalDataComponent extends StatelessWidget {
  const ProfileFormPersonalDataComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileFormPersonalDataBloc,
        ProfileFormPersonalDataState>(
      listener: (context, state) {
        if ((state as ProfileFormPersonalDataInitialState)
                .profileUpdateStatus ==
            ProfileUpdateStatus.updated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Profile updated"),
              duration: Duration(
                seconds: 4,
              ),
            ),
          );

          context.read<ProfileDisplayNameBloc>().add(
                ProfileDisplayNameRefreshEvent(
                    displayName: state.profileModel!.displayName),
              );
        }
      },
      builder: (context, state) {
        if ((state as ProfileFormPersonalDataInitialState).profileModel !=
            null) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationLogoutEvent()),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.logout,
                        ),
                      ),
                    ),
                  ],
                ),
                ProfileUpdateImageComponent(
                  profileModel: state.profileModel!,
                ),
                Expanded(
                  child: InputForm(
                      children: [
                        InputUsername(
                          placeholder: "Enter your username",
                          initialValue: state.profileModel!.displayName,
                        ),
                        InputEmail(
                          placeholder: "Enter your email",
                          initialValue: state.profileModel!.email ?? "",
                        ),
                        InputButton(
                          label: "Enregister",
                        ),
                      ],
                      onSubmitted: (values) {
                        dynamic emailField = values.firstWhere(
                            (element) => element["fieldName"] == "email");

                        dynamic usernameField = values.firstWhere(
                            (element) => element["fieldName"] == "username");

                        context.read<ProfileFormPersonalDataBloc>().add(
                              ProfileFormPersonalDataUpdateEvent(
                                profileModel: ProfileModel(
                                  uid: state.profileModel!.uid,
                                  photoURL: state.profileModel!.photoURL,
                                  displayName:
                                      usernameField["validator"] == null
                                          ? usernameField["value"]
                                          : state.profileModel!.displayName,
                                  email: emailField["validator"] == null
                                      ? emailField["value"]
                                      : state.profileModel!.email,
                                ),
                              ),
                            );
                      }),
                )
              ],
            ),
          );
        }

        return Center(
          child: Text("loading..."),
        );
      },
    );
  }
}
