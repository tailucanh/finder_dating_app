import 'package:chat_app/app/app_config.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/model/params/tokens.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/router/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> with HydratedMixin {
  SettingCubit() : super(const SettingState());

  final userRepository = getIt<UserRepository>();
  final authRepository = getIt<AuthRepository>();

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final tokenUser = await userRepository.getTokenById(id: helpersFunctions.idUser);
      emit(state.copyWith(loadStatus: LoadStatus.success,tokenUser: tokenUser));
    } on FirebaseException {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }


  @override
  SettingState? fromJson(Map<String, dynamic> json) {
    return SettingState(
      themeMode: json['themeMode'] is int
          ? ThemeMode.values[json['themeMode']]
          : ThemeMode.system,
      locale: json['local'] is String
          ? Locale.fromSubtags(languageCode: json['local'])
          : AppConfig.defaultLocal,
    );
  }

  @override
  Map<String, dynamic>? toJson(SettingState state) {
    return {
      'themeMode': state.themeMode.index,
      'local': state.locale.languageCode,
    };
  }

}
