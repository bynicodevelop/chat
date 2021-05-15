import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/abstracts/profile.dart';
import 'package:chat/repositories/models/profile_model.dart';
import 'package:equatable/equatable.dart';

part 'profile_form_personal_data_event.dart';
part 'profile_form_personal_data_state.dart';

class ProfileFormPersonalDataBloc
    extends Bloc<ProfileFormPersonalDataEvent, ProfileFormPersonalDataState> {
  final ProfileRepository _profileRepository;

  ProfileFormPersonalDataBloc(
    this._profileRepository,
  ) : super(ProfileFormPersonalDataInitialState());

  @override
  Stream<ProfileFormPersonalDataState> mapEventToState(
    ProfileFormPersonalDataEvent event,
  ) async* {
    if (event is ProfileFormPersonalDataInitializeEvent) {
      ProfileModel profileModel = await _profileRepository.profile;

      yield ProfileFormPersonalDataInitialState(
        profileModel: profileModel,
      );
    } else if (event is ProfileFormPersonalDataUpdateEvent) {
      yield ProfileFormPersonalDataInitialState(
        profileModel: event.profileModel,
        profileUpdateStatus: ProfileUpdateStatus.loading,
      );

      try {
        await _profileRepository.updateProfile(event.profileModel);

        yield ProfileFormPersonalDataInitialState(
          profileModel: event.profileModel,
          profileUpdateStatus: ProfileUpdateStatus.updated,
        );
      } catch (e) {
        yield ProfileFormPersonalDataInitialState(
          profileModel: event.profileModel,
          profileUpdateStatus: ProfileUpdateStatus.error,
        );
      }
    }
  }
}
