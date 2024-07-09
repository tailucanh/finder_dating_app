import 'dart:io';

import 'package:chat_app/app.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void switchTap(int index) async {
    emit(state.copyWith(selectedIndex: index));
  }

  void changedPosition(Offset position) async {
    emit(state.copyWith(position: position));
  }
  void startAccelerate({bool accelerate = false}) {
    emit(state.copyWith(accelerateStatus: LoadStatus.loading));
    emit(state.copyWith(
        accelerate: accelerate, accelerateStatus: LoadStatus.success));
  }

  Future<bool> checkInternetConnect() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        emit(state.copyWith(internetStatus: true));
        internetCheck = true;
      } else {
        emit(state.copyWith(internetStatus: false));
        internetCheck = false;
      }
    } on SocketException catch (_) {
      emit(state.copyWith(internetStatus: false));
      internetCheck = false;
    }
    return internetCheck;
  }
}
