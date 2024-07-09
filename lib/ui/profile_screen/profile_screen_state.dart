part of 'profile_screen_cubit.dart';

class ProfileScreenState extends Equatable {
  final LoadStatus loadDataStatus;
  final UserEntity? user;
  final bool? isProfileVerified;

  const ProfileScreenState(
      {this.loadDataStatus = LoadStatus.initial, this.user, this.isProfileVerified, });

  @override
  List<Object?> get props => [
    loadDataStatus,
  ];

  ProfileScreenState copyWith({
    LoadStatus? loadDataStatus,
    UserEntity? user,
    bool? isProfileVerified
  }) {
    return ProfileScreenState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      user: user ?? this.user,
      isProfileVerified: isProfileVerified ?? this.isProfileVerified,
    );
  }
}
