import 'package:chat_app/app/app_config.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/entities/pay_entity.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'bills_management_state.dart';

class BillsManagementCubit extends Cubit<BillsManagementState> {
  BillsManagementCubit() : super(const BillsManagementState());
  final userRepository = getIt<UserRepository>();

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final billsSnapshot = await FirebaseFirestore.instance
          .collection(AppConfig.tableUser)
          .doc(helpersFunctions.idUser)
          .collection("bills")
          .get();
      final bills = billsSnapshot.docs.map((e) => PayEntity.fromJson(e.data())).toList();

      final user = await userRepository.getUserProfile();
      emit(state.copyWith(loadStatus: LoadStatus.success, billsList: bills,user: user));
    } on FirebaseException {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
