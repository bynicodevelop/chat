import 'package:chat/layouts/chat/chat_mobile_layout.dart';
import 'package:chat/components/pageview/page_view_component.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/layouts/profile/profile_mobile_layout.dart';
import 'package:chat/responsive.dart';
import 'package:chat/services/pageview/pageview_bloc.dart';
import 'package:chat/helpers/string_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileResponsiveScreen extends StatelessWidget {
  const MobileResponsiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isMobile(context)
          ? AppBar(
              title: Text((kNavigation[(context.watch<PageViewBloc>().state
                          as PageViewInitialState)
                      .indexSelected]["label"]! as String)
                  .firstCapitalized()),
            )
          : null,
      body: SafeArea(
        child: Container(
          color: kSecondaryBackgroundColor,
          child: PageViewComponent(
            messaging: ChatMobileLayout(),
            profile: ProfileMobileLayout(),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => context.read<PageViewBloc>().add(
              PageViewJumpToPage(index),
            ),
        currentIndex:
            (context.watch<PageViewBloc>().state as PageViewInitialState)
                .indexSelected,
        items: kNavigation
            .map<BottomNavigationBarItem>(
              (navigation) => BottomNavigationBarItem(
                icon: Icon(navigation["icon"] as IconData),
                label: navigation["label"] as String,
              ),
            )
            .toList(),
      ),
    );
  }
}
