import 'dart:developer';

import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/enums/load_state.dart';
import 'login_navigator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginNavigator navigator;
  final authRepository = getIt<AuthRepository>();

  LoginCubit({
    required this.navigator,
  }) : super(const LoginState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final auth = await authRepository.loginGoogle();
      emit(state.copyWith(loadDataStatus: LoadStatus.initial));
      final token = await auth?.authentication;
      final check = await authRepository.checkAuth(
          email: auth?.email,
          accessToken: token?.accessToken,
          idToken: token?.idToken);
      if (check == "1") {
        navigator.openPageHome();
      } else {
        final information = await auth?.authentication;
        log("message ${information?.idToken}");
        navigator.openPageLoginGoogle(
            account: auth,
            accessToken: information?.accessToken,
            idToken: information?.idToken);
      }
      emit(state.copyWith(
          loadDataStatus: LoadStatus.success, authentication: auth));
    } catch (e) {
      log("$e");
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
