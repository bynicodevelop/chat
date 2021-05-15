import 'package:chat/components/chat_groups_list_view/chat_groups_list_view_component.dart';
import 'package:chat/components/chat_list_view/chat_list_view_component.dart';
import 'package:chat/config/constants.dart';
import 'package:flutter/material.dart';

class ChatDesktopLayout extends StatelessWidget {
  const ChatDesktopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: kDefaultBackgroundColor,
            child: ChatGroupsListViewComponent(),
          ),
        ),
        Expanded(
          flex: 9,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 5,
            ),
            child: ChatListViewComponent(),
          ),
        )
      ],
    );
  }
}
