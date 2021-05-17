import 'package:chat/components/chat_list_view/bloc/chat_list_view_bloc.dart';
import 'package:chat/components/discussions/item/bloc/discussion_item_bloc.dart';
import 'package:chat/components/discussions/item/discussion_item_component.dart';
import 'package:chat/components/discussions/list/bloc/discussion_list_bloc.dart';
import 'package:chat/components/discussions/tabs/tabs_component.dart';
import 'package:chat/repositories/models/group_model.dart';
import 'package:chat/services/discussion/discussion_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscussionListComponent extends StatelessWidget {
  const DiscussionListComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DiscussionBloc, DiscussionState>(
          listener: (context, state) {
            if ((state as DiscussionInitialState).discussion != null) {
              context.read<ChatListViewBloc>().add(
                    ChatListViewInitializeEvent(
                      groupModel: state.discussion!,
                    ),
                  );

              context.read<DiscussionItemBloc>().add(
                    DiscussionItemSelectedEvent(
                      groupModelSelected: state.discussion!,
                    ),
                  );
            }
          },
        ),
        BlocListener<DiscussionListBloc, DiscussionListState>(
          listener: (context, state) {
            if (state is DiscussionListInitialState) {
              context.read<DiscussionBloc>().add(
                    DiscussionInitializedEvent(
                      discussions: state.discussions,
                      status: "accepted",
                    ),
                  );
            }
          },
        )
      ],
      child: BlocBuilder<DiscussionListBloc, DiscussionListState>(
        builder: (context, state) {
          if (state is DiscussionListInitialState) {
            if (state.discussions.length == 0) {
              return Center(
                child: Text("Aucun discussion..."),
              );
            }

            final int numberAsked = state.discussions
                .where((contact) => contact.status == "waiting")
                .length;

            return TabsComponent(
              onTap: (index) {
                if (index == 0) {
                  context.read<DiscussionBloc>().add(
                        DiscussionInitializedEvent(
                          discussions: state.discussions,
                          status: "accepted",
                        ),
                      );
                }

                if (index == 1) {
                  context.read<DiscussionBloc>().add(
                        DiscussionInitializedEvent(
                          discussions: state.discussions,
                          status: "waiting",
                        ),
                      );
                }
              },
              labels: [
                "Messages",
                numberAsked > 0 ? "Demandes ($numberAsked)" : "Demandes",
              ],
              widgets: [
                ListViewitems(
                  items: state.discussions
                      .where((discussion) => discussion.status == "accepted")
                      .toList(),
                  emptyMessage: "Aucuns discussion",
                ),
                ListViewitems(
                  items: state.discussions
                      .where((discussion) => discussion.status == "waiting")
                      .toList(),
                  emptyMessage: "Aucune demande en cours",
                ),
              ],
            );
          }

          return Text("loading");
        },
      ),
    );
  }
}

class ListViewitems extends StatelessWidget {
  final List<GroupModel> items;
  final String emptyMessage;

  const ListViewitems({
    Key? key,
    required this.items,
    required this.emptyMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.length > 0
        ? ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => DiscussionItemComponent(
              groupModel: items[index],
            ),
          )
        : Center(
            child: Container(
              child: Text(
                emptyMessage,
              ),
            ),
          );
  }
}
