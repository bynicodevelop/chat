import 'package:chat/services/pageview/pageview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class PageViewComponent extends StatelessWidget {
  final Widget messaging;
  final Widget profile;

  late PageController _pageController;

  PageViewComponent({
    Key? key,
    required this.messaging,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PageViewBloc, PageViewState>(
      listener: (context, state) {
        if (state is PageViewInitialState) {
          _pageController.jumpToPage(state.indexSelected);
        }
      },
      builder: (context, state) {
        if (state is PageViewInitialState) {
          _pageController = PageController(
            initialPage: state.indexSelected,
          );
        }

        return PageView(
          controller: _pageController,
          onPageChanged: (index) => context.read<PageViewBloc>().add(
                PageViewJumpToPage(index),
              ),
          children: [
            messaging,
            profile,
          ],
        );
      },
    );
  }
}
