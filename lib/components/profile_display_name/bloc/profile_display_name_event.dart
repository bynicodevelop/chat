part of 'profile_display_name_bloc.dart';

abstract class ProfileDisplayNameEvent extends Equatable {
  const ProfileDisplayNameEvent();

  @override
  List<Object> get props => [];
}

class ProfileDisplayNameRefreshEvent extends ProfileDisplayNameEvent {
  final String displayName;

  ProfileDisplayNameRefreshEvent({
    required this.displayName,
  });
}
