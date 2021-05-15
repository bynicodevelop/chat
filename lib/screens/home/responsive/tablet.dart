import 'package:chat/layouts/chat/chat_tablet_layout.dart';
import 'package:chat/components/pageview/page_view_component.dart';
import 'package:chat/components/side_menu_component.dart';
import 'package:chat/layouts/profile/profile_tablet_layout.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TableResponsiveScreen extends StatelessWidget {
  TableResponsiveScreen({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      endDrawerEnableOpenDragGesture: false,
      drawer: SizedBox(
        width: 100,
        child: Drawer(
          child: SideMenuComponent(),
        ),
      ),
      body: PageViewComponent(
        messaging: ChatTabletLayout(
          drawerKey: _drawerKey,
        ),
        profile: ProfileTabletLayout(
          drawerKey: _drawerKey,
        ),
      ),
    );
  }
}
