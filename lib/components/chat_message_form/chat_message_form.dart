import 'package:chat/components/chat_accept_contact/chat_accept_contact.dart';
import 'package:chat/components/chat_message_form/bloc/chat_message_form_bloc.dart';
import 'package:chat/components/discussions/item/bloc/discussion_item_bloc.dart';
import 'package:chat/components/discussions/list/bloc/discussion_list_bloc.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatMessageFormComponent extends StatelessWidget {
  final String status;
  final String groupId;

  ChatMessageFormComponent({
    Key? key,
    required this.status,
    required this.groupId,
  }) : super(key: key);

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

  Widget _row({
    bool isSending = false,
  }) =>
      Row(
        children: [
          Expanded(
            child: _field(null),
          ),
          BlocBuilder<DiscussionItemBloc, DiscussionItemState>(
            builder: (context, stateItem) =>
                BlocBuilder<DiscussionListBloc, DiscussionListState>(
                    builder: (context, state) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: isSending
                      ? null
                      : () {
                          if (_messageController.text.isNotEmpty) {
                            context.read<ChatMessageFormBloc>().add(
                                  ChatChatMessageEvent(
                                    content: _messageController.text,
                                    chatId: (stateItem
                                            as DiscussionItemInitialState)
                                        .itemSelected,
                                  ),
                                );
                          }
                        },
                  child: Icon(
                    Icons.send,
                    color: kCTAColor,
                  ),
                ),
              );
            }),
          ),
        ],
      );

  Widget _column({
    bool isSending = false,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _field(5),
          ),
          BlocBuilder<DiscussionItemBloc, DiscussionItemState>(
            builder: (context, stateItem) => ElevatedButton(
              onPressed: isSending
                  ? null
                  : () {
                      if (_messageController.text.isNotEmpty) {
                        context.read<ChatMessageFormBloc>().add(
                              ChatChatMessageEvent(
                                content: _messageController.text,
                                chatId:
                                    (stateItem as DiscussionItemInitialState)
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
      builder: (context, state) {
        return status == "waiting"
            ? ChatAcceptContact(
                groupId: groupId,
              )
            : Container(
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
                child: Responsive.isMobile(context)
                    ? _row(
                        isSending: state is ChatMessageFormChatingState,
                      )
                    : _column(
                        isSending: state is ChatMessageFormChatingState,
                      ),
              );
      },
    );
  }
}
