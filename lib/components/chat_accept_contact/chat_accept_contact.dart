import 'package:chat/components/chat_accept_contact/bloc/chat_accept_contact_bloc.dart';
import 'package:chat/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatAcceptContact extends StatelessWidget {
  final String groupId;

  const ChatAcceptContact({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAcceptContactBloc, ChatAcceptContactState>(
      listener: (context, state) {
        if ((state as ChatAcceptContactInitialState).chatAcceptContactStatus ==
            ChatAcceptContactStatus.accepted) {
          // context.read<TabsBloc>().add(
          //       TabsChangedEvent(
          //         index: 0,
          //       ),
          //     );
        }
      },
      builder: (context, state) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: kDefaultPadding / 2,
            ),
            child: Text("Vous avez une nouvelle demande de contact."),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: kDefaultPadding / 2,
            ),
            child: Text("L'acceptez-vous ?"),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: kDefaultPadding / 2,
            ),
            child: SizedBox(
              height: 40.0,
              child: ElevatedButton(
                onPressed: () => context
                    .read<ChatAcceptContactBloc>()
                    .add(ChatAcceptContactAcceptedEvent(
                      groupId: groupId,
                    )),
                child: Text("Confirmer la demande"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: kDefaultPadding,
            ),
            child: TextButton(
              onPressed: () => context.read<ChatAcceptContactBloc>().add(
                    ChatAcceptContactRefusedEvent(
                      groupId: groupId,
                    ),
                  ),
              child: Text("Refuser cette demande"),
            ),
          ),
        ],
      ),
    );
  }
}
