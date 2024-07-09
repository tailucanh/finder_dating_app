import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../di/network_repository.dart';
import 'discover_navigator.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  final DiscoverNavigator navigator;
  final userRepository = getIt<UserRepository>();

  DiscoverCubit({
    required this.navigator,
  }) : super(const DiscoverState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final user = await userRepository.getUserProfile();
      final isProfileVerified = await userRepository.checkVerification();
      emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
          isProfileVerified: isProfileVerified,
          spotifyCheck: user.spotify != null));
    } on FirebaseException {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<bool> checkSpotify() async {
    try {
      final user = await userRepository.getUserProfile();
      debugPrint(user.spotify.toString());
      if (user.spotify != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException {
      return false;
    }
  }
}
