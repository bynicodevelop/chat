import 'package:chat/components/profile_display_name/bloc/profile_display_name_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDisplayNameComponent extends StatefulWidget {
  final String displayName;

  const ProfileDisplayNameComponent({
    Key? key,
    required this.displayName,
  }) : super(key: key);

  @override
  _ProfileDisplayNameComponentState createState() =>
      _ProfileDisplayNameComponentState();
}

class _ProfileDisplayNameComponentState
    extends State<ProfileDisplayNameComponent> {
  @override
  void initState() {
    super.initState();

    context.read<ProfileDisplayNameBloc>().add(
          ProfileDisplayNameRefreshEvent(
            displayName: widget.displayName,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileDisplayNameBloc, ProfileDisplayNameState>(
      builder: (context, state) {
        if (state is ProfileDisplayNameRefreshedState) {
          return Text(state.displayName.toUpperCase());
        }

        return Text("...");
      },
    );
  }
}
