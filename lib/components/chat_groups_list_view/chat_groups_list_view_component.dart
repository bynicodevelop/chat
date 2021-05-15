import 'package:chat/components/chat_groups_item/bloc/chat_groups_item_bloc.dart';
import 'package:chat/components/chat_groups_item/chat_groups_item_component.dart';
import 'package:chat/components/chat_groups_list_view/bloc/chat_group_list_view_bloc.dart';
import 'package:chat/components/chat_list_view/bloc/chat_list_view_bloc.dart';
import 'package:chat/repositories/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatGroupsListViewComponent extends StatelessWidget {
  const ChatGroupsListViewComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatGroupListViewBloc, ChatGroupListViewState>(
      listener: (context, state) {
        if (state is ChatGroupListViewInitialState &&
            state.messaging.length > 0) {
          late GroupModel groupModel;
          int index =
              state.messaging.indexWhere((groupModel) => groupModel.selected);

          if (index == -1) {
            groupModel = state.messaging.first;
          } else {
            groupModel = state.messaging.elementAt(index);
          }

          context.read<ChatListViewBloc>().add(
                ChatListViewInitializeEvent(
                  groupModel: groupModel,
                ),
              );

          context.read<ChatGroupsItemBloc>().add(
                ChatGroupsItemSelectedEvent(
                  groupModelSelected: groupModel,
                ),
              );
        }
      },
      builder: (context, state) {
        if (state is ChatGroupListViewInitialState) {
          if (state.messaging.length == 0) {
            return Center(
              child: Text("Aucun discussion..."),
            );
          }

          return ListView.builder(
            itemCount: state.messaging.length,
            itemBuilder: (context, index) => ChatGroupsItemComponent(
              groupModel: state.messaging[index],
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
