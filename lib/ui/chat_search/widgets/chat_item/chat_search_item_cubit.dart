import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../di/network_repository.dart';
import '../../../../repositories/user_repository.dart';

part 'chat_search_item_state.dart';

class ChatSearchItemCubit extends Cubit<ChatSearchItemState> {

  final userRepository = getIt<UserRepository>();
  ChatSearchItemCubit() : super( ChatSearchItemState());

  Future<void> loadInitialData({required String id}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      final user = await userRepository.getOneUser(id: id);
      emit(state.copyWith(loadDataStatus: LoadStatus.success, userEntity: user));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
