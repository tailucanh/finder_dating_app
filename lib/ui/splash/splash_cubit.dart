import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

import 'splash_navigator.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;
  final auth = getIt<AuthRepository>();
  final currentYear = DateTime.now().year;

  SplashCubit({
    required this.navigator,
  }) : super(const SplashState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      await Future.delayed(const Duration(seconds: 4));
      getApplicationDocumentsDirectory().then((value) {
        helpersFunctions.pathDocument = value.path;
      });
      final check = await auth.checkLogin();
      if (!check) {
        navigator.openLogin();
      } else {
        navigator.openHome();
      }
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
