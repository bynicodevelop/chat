part of 'profile_update_image_bloc.dart';

abstract class ProfileUpdateImageEvent extends Equatable {
  const ProfileUpdateImageEvent();

  @override
  List<Object> get props => [];
}

class ProfileUpdateImageSendEvent extends ProfileUpdateImageEvent {
  final PlatformFile file;

  ProfileUpdateImageSendEvent({
    required this.file,
  });
}
