import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/model/params/tokens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../di/network_repository.dart';
import '../../../../repositories/user_repository.dart';

part 'chat_item_state.dart';

class ChatItemCubit extends Cubit<ChatItemState> {
  final userRepository = getIt<UserRepository>();
  ChatItemCubit() : super(ChatItemState());

  Future<void> loadInitialData({required String id}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      final user = await userRepository.getOneUser(id: id);
      emit(
          state.copyWith(loadDataStatus: LoadStatus.success, userEntity: user));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> getActiveTime({required String id}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final data = await userRepository.getTokenById(id: id);

      emit(state.copyWith(loadDataStatus: LoadStatus.success, tokenTime: data));
    } on FirebaseException {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
