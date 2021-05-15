import 'package:chat/layouts/chat/chat_desktop_layout.dart';
import 'package:chat/components/pageview/page_view_component.dart';
import 'package:chat/components/side_menu_component.dart';
import 'package:chat/layouts/profile/profile_desktop_layout.dart';
import 'package:chat/services/pageview/pageview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesktopResponsiveScreen extends StatelessWidget {
  DesktopResponsiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PageViewBloc, PageViewState>(
        builder: (context, state) => Row(
          children: [
            Expanded(
              flex: 1,
              child: SideMenuComponent(),
            ),
            Expanded(
              flex: 11,
              child: PageViewComponent(
                messaging: ChatDesktopLayout(),
                profile: ProfileDesktopLayout(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
