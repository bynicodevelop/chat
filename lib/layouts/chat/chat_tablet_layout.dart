import 'package:chat/components/chat_groups_list_view/chat_groups_list_view_component.dart';
import 'package:chat/components/chat_list_view/chat_list_view_component.dart';
import 'package:chat/widgets/tablet_drawer_widget.dart';
import 'package:flutter/material.dart';

class ChatTabletLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  const ChatTabletLayout({
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
            child: ChatGroupsListViewComponent(),
          ),
        ),
        Expanded(
          flex: 8,
          child: ChatListViewComponent(),
        )
      ],
    );
  }
}
