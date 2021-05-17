import 'package:chat/components/profile_avatar/bloc/profile_avatar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAvatarComponent extends StatefulWidget {
  final String photoURL;
  final double radius;

  const ProfileAvatarComponent({
    Key? key,
    required this.photoURL,
    this.radius = 60,
  }) : super(key: key);

  @override
  _ProfileAvatarComponentState createState() => _ProfileAvatarComponentState();
}

class _ProfileAvatarComponentState extends State<ProfileAvatarComponent> {
  @override
  void initState() {
    super.initState();

    context.read<ProfileAvatarBloc>().add(
          ProfileAvatarRefreshEvent(
            photoURL: widget.photoURL,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileAvatarBloc, ProfileAvatarState>(
      builder: (context, state) {
        if (state is ProfileAvatarRefreshedState) {
          return CircleAvatar(
            radius: widget.radius,
            backgroundImage:
                state.photoURL.isNotEmpty ? NetworkImage(state.photoURL) : null,
          );
        }

        return CircleAvatar(
          radius: widget.radius,
          child: Text("..."),
        );
      },
    );
  }
}
