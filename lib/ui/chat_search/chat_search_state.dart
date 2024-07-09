part of 'chat_search_cubit.dart';

class ChatSearchState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<CardChat>? listChat;

  const ChatSearchState(
      {this.loadDataStatus = LoadStatus.initial, this.listChat});

  @override
  List<Object?> get props => [loadDataStatus, listChat];

  ChatSearchState copyWith(
      {LoadStatus? loadDataStatus,
      List<CardChat>? listChat,
      List<Story>? listStory,
      LoadStatus? loadStatusStory}) {
    return ChatSearchState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        listChat: listChat ?? this.listChat);
  }
}
