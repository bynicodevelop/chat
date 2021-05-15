import 'package:chat/config/constants.dart';
import 'package:chat/services/pageview/pageview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenuComponent extends StatelessWidget {
  const SideMenuComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
      ),
      child: ListView(
        children: kNavigation
            .map<InkWell>(
              (navigation) => InkWell(
                onTap: () => context
                    .read<PageViewBloc>()
                    .add(PageViewJumpToPage(navigation["index"] as int)),
                child: Container(
                  color: (context.watch<PageViewBloc>().state
                                  as PageViewInitialState)
                              .indexSelected ==
                          navigation["index"]
                      ? kDefaultBackgroundColor
                      : null,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding / 3,
                          top: kDefaultPadding,
                        ),
                        child: Icon(navigation["icon"] as IconData),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kDefaultPadding,
                        ),
                        child: Text(navigation["label"] as String),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
