import 'package:chat/components/profile_form_personal_data/profile_form_personal_data_component.dart';
import 'package:chat/components/profile_navigation/profile_navigation_component.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/widgets/tablet_drawer_widget.dart';
import 'package:flutter/material.dart';

class ProfileTabletLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  const ProfileTabletLayout({
    Key? key,
    required this.drawerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TabletDraweWidget(
            drawerKey: drawerKey,
            child: ProfileNavigationComponent(),
          ),
        ),
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 3,
            ),
            child: ProfileFormPersonalDataComponent(),
          ),
        ),
      ],
    );
  }
}
