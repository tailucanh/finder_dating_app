import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:equatable/equatable.dart';

class TopUserCardState extends Equatable {
  final LoadStatus loadDataStatus;
  final bool? isMatched;
  final UserEntity? currentUser;

  const TopUserCardState({
    this.loadDataStatus = LoadStatus.initial,
    this.isMatched,
    this.currentUser
  });

  @override
  List<Object?> get props =>
      [loadDataStatus, isMatched,currentUser];

  TopUserCardState copyWith(
      {LoadStatus? loadDataStatus, bool? isMatched, UserEntity? currentUser}) {
    return TopUserCardState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      isMatched: isMatched ?? this.isMatched,
      currentUser: currentUser ?? this.currentUser
    );
  }
}
