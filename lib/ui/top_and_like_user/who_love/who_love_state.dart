part of 'who_love_cubit.dart';

class WhoLoveState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<UserEntity>? userFollowers;
  final bool isPrimaryGold;

  const WhoLoveState({
    this.loadDataStatus = LoadStatus.initial,
    this.isPrimaryGold = false,
    this.userFollowers,
  });

  @override
  List<Object?> get props => [loadDataStatus, userFollowers, isPrimaryGold];

  WhoLoveState copyWith(
      {LoadStatus? loadDataStatus,
      List<UserEntity>? userFollowers,
      bool? isPrimaryGold}) {
    return WhoLoveState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      isPrimaryGold: isPrimaryGold ?? this.isPrimaryGold,
      userFollowers: userFollowers ?? this.userFollowers,
    );
  }
}
