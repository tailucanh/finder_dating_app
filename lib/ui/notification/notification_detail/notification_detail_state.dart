part of 'notification_detail_cubit.dart';

class NotificationDetailState extends Equatable {
  final LoadStatus loadDataStatus;
  final UserEntity? userEntity;
  final ChatItem? chatItem;

  const NotificationDetailState(
      {this.loadDataStatus = LoadStatus.initial, this.userEntity, this.chatItem});

  @override
  List<Object?> get props => [loadDataStatus, userEntity,chatItem];

  NotificationDetailState copyWith(
      {LoadStatus? loadDataStatus, UserEntity? userEntity, ChatItem? chatItem}) {
    return NotificationDetailState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        userEntity: userEntity ?? this.userEntity,
        chatItem: chatItem ?? this.chatItem
    );
  }
}
