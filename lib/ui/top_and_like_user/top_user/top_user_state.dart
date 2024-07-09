import 'package:equatable/equatable.dart';
import '../../../model/entities/user_entity.dart';
import '../../../model/enums/load_state.dart';

class TopUserState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<UserEntity>? usersListRecent;
  final List<UserEntity>? usersListCommonInterests;

  const TopUserState({
    this.loadDataStatus = LoadStatus.initial,
    this.usersListRecent,
    this.usersListCommonInterests,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        usersListRecent,
        usersListCommonInterests
      ];

  TopUserState copyWith(
      {LoadStatus? loadDataStatus, List<UserEntity>? usersListRecent,List<UserEntity>? usersListCommonInterests}) {
    return TopUserState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      usersListRecent: usersListRecent ?? this.usersListRecent,
      usersListCommonInterests: usersListCommonInterests ?? this.usersListCommonInterests,
    );
  }
}
