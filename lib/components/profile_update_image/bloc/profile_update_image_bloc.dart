import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/abstracts/profile.dart';
import 'package:chat/repositories/models/profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'profile_update_image_event.dart';
part 'profile_update_image_state.dart';

class ProfileUpdateImageBloc
    extends Bloc<ProfileUpdateImageEvent, ProfileUpdateImageState> {
  ProfileRepository _profileRepository;

  ProfileUpdateImageBloc(
    this._profileRepository,
  ) : super(ProfileUpdateImageInitialState());

  @override
  Stream<ProfileUpdateImageState> mapEventToState(
    ProfileUpdateImageEvent event,
  ) async* {
    if (event is ProfileUpdateImageSendEvent) {
      yield ProfileUpdateImageUpdatingState();

      String photoURL = await _profileRepository.updatePhotoURL(
        data: event.file.bytes,
        path: event.file.path,
      );

      ProfileModel profileModel = await _profileRepository.profile;

      ProfileModel newProfileModel = ProfileModel(
        uid: profileModel.uid,
        photoURL: photoURL,
        displayName: profileModel.displayName,
        email: profileModel.email,
      );

      await _profileRepository.updateProfile(newProfileModel);

      yield ProfileUpdateImageUpdatedState(
        profileModel: newProfileModel,
      );
    }
  }
}
