part of 'discover_cubit.dart';

class DiscoverState extends Equatable {
  final LoadStatus loadDataStatus;
  final bool? spotifyCheck;
  final bool? isProfileVerified;
  const DiscoverState(
      {this.loadDataStatus = LoadStatus.initial,
        this.spotifyCheck = false,
        this.isProfileVerified});

  @override
  List<Object?> get props => [loadDataStatus, spotifyCheck, isProfileVerified];

  DiscoverState copyWith(
      {LoadStatus? loadDataStatus,
        bool? spotifyCheck,
        bool? isProfileVerified}) {
    return DiscoverState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      spotifyCheck: spotifyCheck ?? this.spotifyCheck,
      isProfileVerified: isProfileVerified ?? this.isProfileVerified,
    );
  }
}
