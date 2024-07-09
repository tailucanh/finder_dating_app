
import 'package:chat_app/model/entities/chat_item.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/chat_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../di/network_repository.dart';

part 'notification_detail_state.dart';

class NotificationDetailCubit extends Cubit<NotificationDetailState> {
  NotificationDetailCubit() : super(const NotificationDetailState());
  final data = getIt<UserRepository>();
  final notification = getIt<ChatRepository>();
  final chatRepository = getIt<ChatRepository>();


  Future<void> loadInitialData({String? id}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      final user = await data.getOneUser(id: id);
      final chatItem = await chatRepository.getChatByUid(opponentUid: id ?? '');
      emit(state.copyWith(loadDataStatus: LoadStatus.success, userEntity: user, chatItem: chatItem));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
  Future<void> updateStatusNotification({required String id,required String time, required String status}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      await notification.updateStatusNotification(id: id,time: time, status: status);
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }



}
