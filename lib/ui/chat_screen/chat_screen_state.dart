part of 'chat_screen_cubit.dart';

class ChatScreenState extends Equatable {
  final LoadStatus loadDataStatus;
  final Stream<List<CardChat>?>? listChat;
  final LoadStatus loadStatusStory;
  final List<StoryCard>? listStory;

  const ChatScreenState(
      {this.loadDataStatus = LoadStatus.initial,
      this.listChat,
      this.listStory,
      this.loadStatusStory = LoadStatus.initial});

  @override
  List<Object?> get props =>
      [loadDataStatus, listChat, listStory, loadStatusStory];

  ChatScreenState copyWith(
      {LoadStatus? loadDataStatus,
      Stream<List<CardChat>?>? listChat,
      List<StoryCard>? listStory,
      LoadStatus? loadStatusStory}) {
    return ChatScreenState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        listStory: listStory ?? this.listStory,
        loadStatusStory: loadStatusStory ?? this.loadStatusStory,
        listChat: listChat ?? this.listChat,
    );
  }
}
