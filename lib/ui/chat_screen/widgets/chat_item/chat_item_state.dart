part of 'chat_item_cubit.dart';

class ChatItemState extends Equatable {
  final LoadStatus loadDataStatus;
   UserEntity? userEntity;
   Tokens? tokenTime;

   ChatItemState({
    this.loadDataStatus = LoadStatus.initial,
    this.userEntity,
    this.tokenTime,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
         userEntity,
    tokenTime
      ];

  ChatItemState copyWith({
    LoadStatus? loadDataStatus,
    UserEntity? userEntity,
    Tokens? tokenTime,
  }) {
    return ChatItemState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      userEntity: userEntity ?? this.userEntity,
      tokenTime: tokenTime ?? this.tokenTime,
    );
  }
}
