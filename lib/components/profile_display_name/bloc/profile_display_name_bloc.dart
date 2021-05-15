import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_display_name_event.dart';
part 'profile_display_name_state.dart';

class ProfileDisplayNameBloc
    extends Bloc<ProfileDisplayNameEvent, ProfileDisplayNameState> {
  ProfileDisplayNameBloc() : super(ProfileDisplayNameInitial());

  @override
  Stream<ProfileDisplayNameState> mapEventToState(
    ProfileDisplayNameEvent event,
  ) async* {
    if (event is ProfileDisplayNameRefreshEvent) {
      yield ProfileDisplayNameRefreshingState();

      yield ProfileDisplayNameRefreshedState(
        event.displayName,
      );
    }
  }
}
