import 'package:chat/components/discussions/tabs/bloc/tabs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabsComponent extends StatelessWidget {
  final List<String> labels;
  final List<Widget> widgets;
  final void Function(int) onTap;

  const TabsComponent({
    Key? key,
    required this.labels,
    required this.widgets,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widgets.length,
      child: BlocBuilder<TabsBloc, TabsState>(
        builder: (context, state) => Column(
          children: [
            TabBar(
              onTap: onTap,
              tabs: labels
                  .map<Tab>(
                    (label) => Tab(
                      child: Text(label),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                children: widgets,
              ),
            )
          ],
        ),
      ),
    );
  }
}
