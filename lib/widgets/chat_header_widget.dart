import 'package:chat/components/chat_list_view/bloc/chat_list_view_bloc.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/repositories/models/profile_model.dart';
import 'package:chat/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatHeaderWidget extends StatelessWidget {
  const ChatHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListViewBloc, ChatListViewState>(
      builder: (context, state) {
        ProfileModel? profileModel;

        final bool hasMessage =
            (state as ChatListViewInitialState).messages.length > 0;

        if (hasMessage) {
          profileModel = state.members.firstWhere((member) => !member.isMe);
        }

        return Material(
          elevation: kDefaultPadding / 4,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding / 3,
              horizontal: kDefaultPadding / 1.3,
            ),
            height: kToolbarHeight,
            decoration: BoxDecoration(
              color: kDefaultBackgroundColor,
            ),
            child: Row(
              children: [
                Visibility(
                  visible: Responsive.isMobile(context),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: kDefaultPadding / 2,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: kDefaultPadding / 3,
                  ),
                  child: CircleAvatar(
                    backgroundImage: hasMessage
                        ? NetworkImage(profileModel!.photoURL)
                        : null,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 4),
                      child: Text(
                        (hasMessage ? profileModel!.displayName : "")
                            .toUpperCase(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
