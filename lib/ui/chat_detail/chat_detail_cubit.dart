import 'dart:async';

import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/entities/message.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  final chatRepository = getIt<ChatRepository>();

  ChatDetailCubit() : super(const ChatDetailState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      emit(state.copyWith(
          loadDataStatus: LoadStatus.success, isRecording: false));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void setRecording(bool isRecording) {
    emit(state.copyWith(
        loadDataStatus: LoadStatus.success, isRecording: isRecording));
  }

}
