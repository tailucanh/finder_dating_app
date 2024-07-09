part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<NotificationItem>? list;
  final UserEntity? userEntity;

  const NotificationState(
      {this.loadDataStatus = LoadStatus.initial, this.list, this.userEntity});

  @override
  List<Object?> get props => [loadDataStatus, list, userEntity];

  NotificationState copyWith(
      {LoadStatus? loadDataStatus, List<NotificationItem>? list}) {
    return NotificationState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        list: list ?? this.list,
        userEntity: userEntity ?? this.userEntity
    );
  }
}
