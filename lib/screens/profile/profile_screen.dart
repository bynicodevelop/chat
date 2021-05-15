import 'package:chat/components/profile_form_personal_data/profile_form_personal_data_component.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ProfileFormPersonalDataComponent(),
      ),
    );
  }
}
