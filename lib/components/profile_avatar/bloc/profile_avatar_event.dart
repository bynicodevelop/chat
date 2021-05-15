part of 'profile_avatar_bloc.dart';

abstract class ProfileAvatarEvent extends Equatable {
  const ProfileAvatarEvent();

  @override
  List<Object> get props => [];
}

class ProfileAvatarRefreshEvent extends ProfileAvatarEvent {
  final String photoURL;

  ProfileAvatarRefreshEvent({
    required this.photoURL,
  });
}
