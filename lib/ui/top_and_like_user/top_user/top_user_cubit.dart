
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/top_user_navigator.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/top_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TopUserCubit extends Cubit<TopUserState> {
  final TopUserNavigator navigator;
  final userRepository = getIt<UserRepository>();

  TopUserCubit({
    required this.navigator,
  }) : super(const TopUserState());

  Future<void> loadInitialRecentActive() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final usersListRecent = await userRepository.getUsersTopRecentActive();
      final usersListCommon = await userRepository.getUsersTopCommonInterest();

      emit(state.copyWith(
          loadDataStatus: LoadStatus.success, usersListRecent: usersListRecent,usersListCommonInterests: usersListCommon));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }


}
