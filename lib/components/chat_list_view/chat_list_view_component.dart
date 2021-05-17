import 'package:chat/components/chat_list_view/bloc/chat_list_view_bloc.dart';
import 'package:chat/components/chat_message_form/bloc/chat_message_form_bloc.dart';
import 'package:chat/components/chat_message_form/chat_message_form.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/responsive.dart';
import 'package:chat/widgets/chat_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatListViewComponent extends StatelessWidget {
  ChatListViewComponent({Key? key}) : super(key: key);

  ScrollController _scrollController = ScrollController();

  Row _from(
    String content,
    String photoURL,
    bool isSameUser,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15.0,
            backgroundColor:
                isSameUser ? Colors.transparent : kDefaultBackgroundColor,
            backgroundImage:
                photoURL.isNotEmpty ? NetworkImage(photoURL) : null,
          ),
          _bubble(
            content,
            TextAlign.right,
            kDefautFontColor,
            Color.fromRGBO(225, 255, 199, 1.0),
          ),
        ],
      );

  Row _me(
    String content,
    String photoURL,
    bool isSameUser,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bubble(
            content,
            TextAlign.left,
            Colors.white,
            kCTAColor,
          ),
          CircleAvatar(
            radius: 15.0,
            backgroundColor:
                isSameUser ? Colors.transparent : kDefaultBackgroundColor,
            backgroundImage:
                photoURL.isNotEmpty ? NetworkImage(photoURL) : null,
          ),
        ],
      );

  Widget _bubble(
    String content,
    TextAlign textAlign,
    Color color,
    Color backgroundColor,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding / 3,
          horizontal: kDefaultPadding / 5,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 310,
          ),
          padding: const EdgeInsets.all(
            kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                kDefaultPadding / 2,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  .2,
                ),
                offset: Offset(
                  0.0,
                  1.0,
                ),
                blurRadius: kDefaultPadding / 5,
              ),
            ],
          ),
          child: Text(
            content,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: color,
              height: 1.3,
              letterSpacing: .3,
            ),
          ),
        ),
      );

  Widget _noDiscussion(BuildContext context, state) => Stack(
        children: [
          Center(
            child: Text("Envoyez votre premier message..."),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom:
                MediaQuery.of(context).viewInsets.bottom + kDefaultPadding / 2,
            child: ChatMessageFormComponent(
              status: (state as ChatListViewInitialState).status,
              groupId: state.groupId,
            ),
          ),
        ],
      );

  Widget _messaginStack(BuildContext context, state) => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: Responsive.isMobile(context) ? 80 : 150,
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding / 2,
                // horizontal: kDefaultPadding * 3,
              ),
              controller: _scrollController,
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                if (!state.messages[index].isMe) {
                  return _from(
                    state.messages[index].content,
                    state.messages[index].profileModel.photoURL,
                    index > 1 && !state.messages[index - 1].isMe,
                  );
                }

                return _me(
                  state.messages[index].content,
                  state.messages[index].profileModel.photoURL,
                  index > 1 && state.messages[index - 1].isMe,
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom:
                MediaQuery.of(context).viewInsets.bottom + kDefaultPadding / 2,
            child: ChatMessageFormComponent(
              status: (state as ChatListViewInitialState).status,
              groupId: state.groupId,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatListViewBloc, ChatListViewState>(
      listener: (context, state) {
        if (state is ChatListViewInitialState) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            _scrollController.jumpTo(
              _scrollController.position.maxScrollExtent,
            );
          });
        }
      },
      builder: (context, state) {
        return ClipRRect(
          child: Column(
            children: [
              // In Widget Directory
              ChatHeaderWidget(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                  ),
                  child: (state as ChatListViewInitialState).isFirstContact
                      ? _noDiscussion(context, state)
                      : _messaginStack(context, state),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
