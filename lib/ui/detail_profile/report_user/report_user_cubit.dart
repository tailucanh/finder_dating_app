import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/ui/detail_profile/report_user/report_user_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../config/helpers/helpers_database.dart';
import '../../../di/network_repository.dart';
import '../../../generated/l10n.dart';


class ReportUserCubit extends Cubit<ReportUserState> {
  final userRepository = getIt<UserRepository>();
   ReportUserCubit() : super(const ReportUserState());


  Future<void> reportUser({String? idUser, String? reasonTitle, String? reasonDetail, String? content}) async {
    emit(state.copyWith(reportStatus: LoadStatus.loading));
    try {
     final isReport =  await userRepository.reportUser(id: idUser,reasonTitle: reasonTitle,reasonDetail: reasonDetail, content: content);
      if(isReport){
        emit(state.copyWith(reportStatus: LoadStatus.success));
      }else {
        emit(state.copyWith(reportStatus: LoadStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(reportStatus: LoadStatus.failure));
    }
  }

  changeStatusPage() async {
    emit(state.copyWith(reportStatus: LoadStatus.initial));
  }
  changePage({required int indexPage}) async {
    emit(state.copyWith(indexPage: indexPage,reportStatus: LoadStatus.success));
  }

  changeReasonTitle({required String reasonTitle}) async {
    emit(state.copyWith(reasonTitle: reasonTitle,reportStatus: LoadStatus.success));
  }
  changeReasonDetail({required String reasonDetail}) async {
    emit(state.copyWith(reasonDetail: reasonDetail,reportStatus: LoadStatus.success));
  }
  changeContent({required String content}) async {
    emit(state.copyWith(content: content,reportStatus: LoadStatus.success));
  }

}
