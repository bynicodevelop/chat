part of 'profile_avatar_bloc.dart';

abstract class ProfileAvatarState extends Equatable {
  const ProfileAvatarState();

  @override
  List<Object> get props => [];
}

class ProfileAvatarInitialState extends ProfileAvatarState {}

class ProfileAvatarRefreshingState extends ProfileAvatarState {}

class ProfileAvatarRefreshedState extends ProfileAvatarState {
  final String photoURL;

  ProfileAvatarRefreshedState(this.photoURL);

  @override
  List<Object> get props => [photoURL];
}
