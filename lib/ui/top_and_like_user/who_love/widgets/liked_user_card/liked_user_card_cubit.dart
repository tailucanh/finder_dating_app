import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/chat_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'liked_user_card_state.dart';


class LikedUserCardCubit extends Cubit<LikedUserCardState> {
  final userRepository = getIt<UserRepository>();
  final chatRepository = getIt<ChatRepository>();

  LikedUserCardCubit() : super(const LikedUserCardState());

  Future<void> loadInitialData(String id) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final isMatched = await userRepository.checkFollow(id, helpersFunctions.idUser);
      if (isMatched) {
        final chatItem = await chatRepository.getChatByUid(opponentUid: id);
        emit(state.copyWith(
            loadDataStatus: LoadStatus.success,
            isMatched: isMatched,
            idChat: chatItem?.id));
      } else {
        emit(state.copyWith(
            loadDataStatus: LoadStatus.success, isMatched: isMatched));
      }
    } catch (e) {
      debugPrint("fail to check matched");
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> followUser(String uid) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final followed = await userRepository.followUser(uid: uid);
      if (followed!) {
        await userRepository.createChatsItem(uid: uid);
        loadInitialData(uid);
      }
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future removeFollower(String uid) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      await userRepository.removeFollow(helpersFunctions.idUser, uid).then(
          (value) => emit(state.copyWith(loadDataStatus: LoadStatus.success)));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }


}
