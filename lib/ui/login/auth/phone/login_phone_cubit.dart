import 'dart:developer';

import 'package:chat_app/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/network_repository.dart';
import '../../../../model/enums/load_state.dart';
import 'login_phone_navigator.dart';
import 'login_phone_state.dart';

class LoginPhoneCubit extends Cubit<LoginPhoneState> {
  final authRepository = getIt<AuthRepository>();
  LoginPhoneNavigator navigator;

  LoginPhoneCubit({required this.navigator}) : super(const LoginPhoneState());

  Future<void> onChangeNumberPhone(String value) async {
    try {
      if (value.length >= 10) {
        final result = await authRepository.loginPhone(
            state.codeCountry, value, navigator);
        log("message $result");
        if (result != null) {
          navigator.openSmsOtp(id: result);
        }
      }
      emit(state.copyWith(numberPhone: value));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> onChangeCodeCountry(String value) async {
    try {
      emit(state.copyWith(codeCountry: value));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> onChangeCodeSms(String value) async {
    try {
      emit(state.copyWith(codeSms: value));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
