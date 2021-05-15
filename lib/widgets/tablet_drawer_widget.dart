import 'package:chat/config/constants.dart';
import 'package:flutter/material.dart';

class TabletDraweWidget extends StatelessWidget {
  final Widget child;

  const TabletDraweWidget({
    Key? key,
    required this.drawerKey,
    required this.child,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> drawerKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDefaultBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding,
            ),
            child: InkWell(
              child: Icon(Icons.menu),
              onTap: () => drawerKey.currentState!.openDrawer(),
            ),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
