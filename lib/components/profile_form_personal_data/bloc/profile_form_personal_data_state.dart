part of 'profile_form_personal_data_bloc.dart';

enum ProfileUpdateStatus {
  initial,
  loading,
  updated,
  error,
}

abstract class ProfileFormPersonalDataState extends Equatable {
  const ProfileFormPersonalDataState();

  @override
  List<Object> get props => [];
}

class ProfileFormPersonalDataInitialState extends ProfileFormPersonalDataState {
  final ProfileModel? profileModel;
  final ProfileUpdateStatus profileUpdateStatus;

  ProfileFormPersonalDataInitialState({
    this.profileModel,
    this.profileUpdateStatus = ProfileUpdateStatus.initial,
  });

  @override
  List<Object> get props => [profileUpdateStatus];
}
