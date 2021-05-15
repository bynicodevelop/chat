import 'package:chat/components/inputs/input_button.dart';
import 'package:chat/components/inputs/input_email.dart';
import 'package:chat/components/inputs/input_form.dart';
import 'package:chat/components/inputs/input_password.dart';
import 'package:chat/components/profile_form_personal_data/profile_form_personal_data_component.dart';
import 'package:chat/components/profile_navigation/profile_navigation_component.dart';
import 'package:chat/config/constants.dart';
import 'package:flutter/material.dart';

class ProfileDesktopLayout extends StatelessWidget {
  const ProfileDesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ProfileNavigationComponent(),
        ),
        Expanded(
          flex: 9,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 8,
            ),
            child: ProfileFormPersonalDataComponent(),
          ),
        ),
      ],
    );
  }
}
