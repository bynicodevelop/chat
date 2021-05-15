part of 'profile_display_name_bloc.dart';

abstract class ProfileDisplayNameState extends Equatable {
  const ProfileDisplayNameState();

  @override
  List<Object> get props => [];
}

class ProfileDisplayNameInitial extends ProfileDisplayNameState {}

class ProfileDisplayNameRefreshingState extends ProfileDisplayNameState {}

class ProfileDisplayNameRefreshedState extends ProfileDisplayNameState {
  final String displayName;

  ProfileDisplayNameRefreshedState(this.displayName);

  @override
  List<Object> get props => [displayName];
}
