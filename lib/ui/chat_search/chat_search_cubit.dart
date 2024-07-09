
import 'package:chat_app/model/entities/story.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/model/params/card_chat.dart';
import 'package:chat_app/repositories/chat_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../di/network_repository.dart';
import 'chat_search_navigator.dart';

part 'chat_search_state.dart';

class ChatSearchCubit extends Cubit<ChatSearchState> {
  final ChatSearchNavigator navigator;
  final chatRepository = getIt<ChatRepository>();
  final userRepository = getIt<UserRepository>();

  ChatSearchCubit({
    required this.navigator,
  }) : super(const ChatSearchState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.success, listChat: []));
    } on FirebaseException {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> search(String username) async {
    emit(state.copyWith(loadStatusStory: LoadStatus.loading));
    try {
      if (username.isEmpty) {
        emit(state.copyWith(loadStatusStory: LoadStatus.success, listChat: []));
        return;
      }

      final cardChatList = await chatRepository.searchChatByUsername(username);
      debugPrint(cardChatList.toString());
      emit(state.copyWith(
          loadStatusStory: LoadStatus.success, listChat: cardChatList));
    } on FirebaseException {
      emit(state.copyWith(loadStatusStory: LoadStatus.failure));
    }
  }
}
