import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/chat_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/widgets/top_user_card_state.dart';
import 'package:flutter/material.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';


class TopUserCardCubit extends Cubit<TopUserCardState> {
  final userRepository = getIt<UserRepository>();
  final chatRepository = getIt<ChatRepository>();

  TopUserCardCubit() : super(const TopUserCardState());

  Future<void> loadInitialData(String id) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final isMatched = await userRepository.checkFollow(id, helpersFunctions.idUser);
      final currentUser = await userRepository.getUserProfile();
        emit(state.copyWith(
            loadDataStatus: LoadStatus.success,
            currentUser: currentUser,
            isMatched: isMatched));

    } catch (e) {
      debugPrint("fail to check matched");
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }


}
