part of 'profile_form_personal_data_bloc.dart';

abstract class ProfileFormPersonalDataEvent extends Equatable {
  const ProfileFormPersonalDataEvent();

  @override
  List<Object> get props => [];
}

class ProfileFormPersonalDataInitializeEvent
    extends ProfileFormPersonalDataEvent {}

class ProfileFormPersonalDataUpdateEvent extends ProfileFormPersonalDataEvent {
  final ProfileModel profileModel;

  ProfileFormPersonalDataUpdateEvent({
    required this.profileModel,
  });
}
