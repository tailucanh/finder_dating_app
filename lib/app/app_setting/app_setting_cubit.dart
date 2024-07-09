import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/router/router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../app_config.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> with HydratedMixin {
  AppSettingCubit() : super(const AppSettingState());
  final authRepository = getIt<AuthRepository>();

  Future<void> saveSetting({required Locale locale}) async {
    emit(state.copyWith(locale: locale));
  }

  Future<void> changeMode({required ThemeMode themeMode}) async {
    emit(state.copyWith(themeMode: themeMode));
  }
  Future<void> logout(BuildContext context) async {
    try {
      await ZegoUIKitPrebuiltCallInvitationService().uninit();
      await authRepository
          .logout()
          .then((value) => context.pushReplacementNamed(AppRoutes.welcome));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  AppSettingState? fromJson(Map<String, dynamic> json) {
    return AppSettingState(
      themeMode: json['themeMode'] is int
          ? ThemeMode.values[json['themeMode']]
          : ThemeMode.system,
      locale: json['local'] is String
          ? Locale.fromSubtags(languageCode: json['local'])
          : AppConfig.defaultLocal,
    );
  }

  @override
  Map<String, dynamic>? toJson(AppSettingState state) {
    return {
      'themeMode': state.themeMode.index,
      'local': state.locale.languageCode,
    };
  }
}
