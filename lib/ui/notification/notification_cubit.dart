import 'dart:developer';

import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/model/params/notification_item.dart';
import 'package:chat_app/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/entities/user_entity.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final notification = getIt<ChatRepository>();

  NotificationCubit() : super(const NotificationState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      final data = await notification.getListNotification();
      log("message $data");
      emit(state.copyWith(loadDataStatus: LoadStatus.success, list: data));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
