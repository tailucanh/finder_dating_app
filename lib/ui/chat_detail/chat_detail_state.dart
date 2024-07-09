part of 'chat_detail_cubit.dart';

class ChatDetailState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<Message>? listMessage;
  final bool? isRecording;

  const ChatDetailState(
      {this.loadDataStatus = LoadStatus.initial, this.listMessage, this.isRecording = false});

  @override
  List<Object?> get props => [loadDataStatus, listMessage,isRecording];

  ChatDetailState copyWith({
    LoadStatus? loadDataStatus,
    List<Message>? listMessage,
    bool? isRecording,
  }) {
    return ChatDetailState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      listMessage: listMessage ?? this.listMessage,
      isRecording: isRecording ?? this.isRecording,
    );
  }
}
