import 'package:chat/components/chat_groups_item/bloc/chat_groups_item_bloc.dart';
import 'package:chat/components/chat_groups_list_view/bloc/chat_group_list_view_bloc.dart';
import 'package:chat/components/chat_message_form/bloc/chat_message_form_bloc.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatMessageFormComponent extends StatelessWidget {
  ChatMessageFormComponent({Key? key}) : super(key: key);

  final TextEditingController _messageController = TextEditingController();

  Widget _field(int? maxLines) => TextField(
        controller: _messageController,
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(
            kDefaultPadding / 3,
          ),
          hintText: "Tape a message",
          hintStyle: TextStyle(
            color: kSecondaryColor,
            fontSize: kDefaultFontSize,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      );

  Widget _row() => Row(
        children: [
          Expanded(
            child: _field(null),
          ),
          BlocBuilder<ChatGroupsItemBloc, ChatGroupsItemState>(
            builder: (context, stateItem) =>
                BlocBuilder<ChatGroupListViewBloc, ChatGroupListViewState>(
              builder: (context, state) => Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => context.read<ChatMessageFormBloc>().add(
                        ChatChatMessageEvent(
                          content: _messageController.text,
                          chatId: (stateItem as ChatGroupsItemInitialState)
                              .itemSelected,
                        ),
                      ),
                  child: Icon(
                    Icons.send,
                    color: kCTAColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget _column() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _field(5),
          ),
          BlocBuilder<ChatGroupsItemBloc, ChatGroupsItemState>(
            builder: (context, stateItem) =>
                BlocBuilder<ChatGroupListViewBloc, ChatGroupListViewState>(
              builder: (context, state) => ElevatedButton(
                onPressed: () {
                  if (_messageController.text.isNotEmpty) {
                    context.read<ChatMessageFormBloc>().add(
                          ChatChatMessageEvent(
                            content: _messageController.text,
                            chatId: (stateItem as ChatGroupsItemInitialState)
                                .itemSelected,
                          ),
                        );
                  }
                },
                child: Text(
                  "Envoyer".toUpperCase(),
                  style: TextStyle(
                    fontSize: kDefaultFontSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatMessageFormBloc, ChatMessageFormState>(
      listener: (context, state) {
        if (state is ChatMessageFormSentState) {
          _messageController.text = "";
        }
      },
      builder: (context, state) => Container(
        height: Responsive.isMobile(context) ? null : 140,
        padding: const EdgeInsets.all(
          kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: kSecondaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              kDefaultPadding / 2,
            ),
          ),
        ),
        child: Responsive.isMobile(context) ? _row() : _column(),
      ),
    );
  }
}
