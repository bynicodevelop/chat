import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/abstracts/profile.dart';
import 'package:chat/repositories/models/profile_model.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository _profileRepository;

  ProfileBloc(
    this._profileRepository,
  ) : super(ProfileInitialState());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileInitializeEvent) {
      ProfileModel profileModel = await _profileRepository.profile;

      yield ProfileInitialState(
        profileModel: profileModel,
      );
    }
  }
}
