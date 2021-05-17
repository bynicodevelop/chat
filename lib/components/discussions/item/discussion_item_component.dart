import 'package:chat/components/chat_list_view/bloc/chat_list_view_bloc.dart';
import 'package:chat/components/discussions/item/bloc/discussion_item_bloc.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/repositories/models/group_model.dart';
import 'package:chat/responsive.dart';
import 'package:chat/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscussionItemComponent extends StatelessWidget {
  final GroupModel groupModel;

  const DiscussionItemComponent({
    Key? key,
    required this.groupModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscussionItemBloc, DiscussionItemState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: (state as DiscussionItemInitialState).itemSelected ==
                            groupModel.channelId &&
                        !Responsive.isMobile(context)
                    ? kCTAColor
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: ListTile(
              contentPadding: const EdgeInsets.all(kDefaultPadding),
              leading: CircleAvatar(
                backgroundImage: groupModel.avatar.isNotEmpty
                    ? NetworkImage(groupModel.avatar)
                    : null,
              ),
              title: Text(groupModel.username.toUpperCase()),
              subtitle: Text(
                groupModel.content.isEmpty
                    ? "Ecrivez votre premier message"
                    : groupModel.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                context.read<ChatListViewBloc>().add(
                      ChatListViewInitializeEvent(
                        groupModel: groupModel,
                      ),
                    );

                context.read<DiscussionItemBloc>().add(
                      DiscussionItemSelectedEvent(
                        groupModelSelected: groupModel,
                      ),
                    );

                if (Responsive.isMobile(context)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(),
                    ),
                  );
                }
              }),
        );
      },
    );
  }
}
