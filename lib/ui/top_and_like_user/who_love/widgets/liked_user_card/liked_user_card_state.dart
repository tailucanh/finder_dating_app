import 'package:chat_app/model/enums/load_state.dart';
import 'package:equatable/equatable.dart';

class LikedUserCardState extends Equatable {
  final LoadStatus loadDataStatus;
  final bool? isMatched;
  final String? idChat;

  const LikedUserCardState({
    this.loadDataStatus = LoadStatus.initial,
    this.isMatched,
    this.idChat,
  });

  @override
  List<Object?> get props =>
      [loadDataStatus, isMatched, idChat];

  LikedUserCardState copyWith(
      {LoadStatus? loadDataStatus, bool? isMatched, String? idChat}) {
    return LikedUserCardState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      isMatched: isMatched ?? this.isMatched,
      idChat: idChat ?? this.idChat,
    );
  }
}
