part of 'profile_update_image_bloc.dart';

abstract class ProfileUpdateImageState extends Equatable {
  const ProfileUpdateImageState();

  @override
  List<Object> get props => [];
}

class ProfileUpdateImageInitialState extends ProfileUpdateImageState {}

class ProfileUpdateImageUpdatingState extends ProfileUpdateImageState {}

class ProfileUpdateImageUpdatedState extends ProfileUpdateImageState {
  final ProfileModel profileModel;

  ProfileUpdateImageUpdatedState({
    required this.profileModel,
  });

  @override
  List<Object> get props => [profileModel];
}
