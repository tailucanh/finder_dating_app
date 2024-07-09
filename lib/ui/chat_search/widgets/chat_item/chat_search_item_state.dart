part of 'chat_search_item_cubit.dart';

class ChatSearchItemState extends Equatable {
  final LoadStatus loadDataStatus;
   UserEntity? userEntity;

   ChatSearchItemState({
    this.loadDataStatus = LoadStatus.initial,
    this.userEntity,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
         userEntity
      ];

  ChatSearchItemState copyWith({
    LoadStatus? loadDataStatus,
    UserEntity? userEntity,
  }) {
    return ChatSearchItemState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      userEntity: userEntity ?? this.userEntity,
    );
  }
}
