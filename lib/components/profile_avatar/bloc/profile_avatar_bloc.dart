import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_avatar_event.dart';
part 'profile_avatar_state.dart';

class ProfileAvatarBloc extends Bloc<ProfileAvatarEvent, ProfileAvatarState> {
  ProfileAvatarBloc() : super(ProfileAvatarInitialState());

  @override
  Stream<ProfileAvatarState> mapEventToState(
    ProfileAvatarEvent event,
  ) async* {
    if (event is ProfileAvatarRefreshEvent) {
      yield ProfileAvatarRefreshingState();

      yield ProfileAvatarRefreshedState(
        event.photoURL,
      );
    }
  }
}
