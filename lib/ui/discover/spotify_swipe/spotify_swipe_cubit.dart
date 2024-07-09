import 'dart:developer';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/services/location_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:just_audio/just_audio.dart';

import 'spotify_swipe_navigator.dart';
import 'spotify_swipe_state.dart';

class SpotifySwipeCubit extends Cubit<SpotifySwipeState> {
  final SpotifySwipeNavigator navigator;
  final userRepository = getIt<UserRepository>();
  final authRepository = getIt<AuthRepository>();
  AudioPlayer audioPlayer = AudioPlayer();

  SpotifySwipeCubit({
    required this.navigator,
  }) : super(const SpotifySwipeState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final user = await userRepository.getUserProfile();

      final users = await userRepository.getUsersHaveSpotify(user.requestToShow);

      List<GeoPoint> listLocation = [];

      if ((users ?? []).isNotEmpty) {
        for (UserEntity user in users ?? []) {
          final location = await userRepository.getLocationUserById(id: user.uid);
          log("${user.fullName} ${location!.latitude}  ${location.longitude} ${user.spotify!.previewUrl}");
          listLocation.add(location);
        }
      }
      //Play Music
      if ((users ?? []).isNotEmpty) {
        audioPlayer.setUrl(users![0].spotify?.previewUrl ?? "");
        audioPlayer.play();
      }

      Duration? duration =
      await audioPlayer.setUrl(users![0].spotify?.previewUrl ?? "");
      audioPlayer.play();
      emit(state.copyWith(
        loadDataStatus: LoadStatus.success,
        listUser: users,
        locationUser: listLocation,
        songDurationInMillisecond: duration?.inMilliseconds ?? 0,
        isPlaying: audioPlayer.playing,
      ));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }




  Future<void> getLocation() async {
    try {
      await userRepository.getLocationUser();
      String? address = await getLocationCity(
          latitude: helpersFunctions.userLatitude,
          longitude: helpersFunctions.userLongitude);
      await userRepository.updateCurrentAddressUser(address: address ?? "");
    } on FirebaseException {
      emit(state.copyWith(
          loadDataStatus: LoadStatus.failure, locationCheck: false));
    }
  }

  Future<void> saveToken() async {
    try {
      await userRepository.saveToken();
    } on FirebaseException {
      emit(state.copyWith(
          loadDataStatus: LoadStatus.failure, locationCheck: false));
    }
  }

  Future<void> getOne(
      {required CardSwiperDirection direction, required String id}) async {
    emit(state.copyWith(
        loadDataStatus: LoadStatus.loadingMore,
        followStatus: LoadStatus.initial));
    try {

      bool? checkFollower;

      if (direction.name == "right") {
        checkFollower = await userRepository.followUser(uid: id);
        // thông báo cho người kia là mình đã match nta
        await userRepository.pushNotification(
            type: 'match', message: S.current.newFriends, uid: id);
        if (checkFollower ?? false) {
          // thông báo khi cả 2 người cùng match nhau
          UserEntity? user = await userRepository.getOneUser(id: id);
          emit(state.copyWith(userMatch: user));
          await userRepository.pushNotification(
              title: S().notificationScreenContent_Match,
              type: 'match',
              message: S.current.notificationScreenView,
              uid: id);
          await userRepository.createChatsItem(uid: id);
          emit(state.copyWith(followStatus: LoadStatus.success));
        }
        emit(state.copyWith(
            followStatus: LoadStatus.success,
            checkFollower: checkFollower));
      }

      emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        loadDataStatus: LoadStatus.failure,
      ));
    }
  }

  void setPreviewUrl(String url) {
    emit(state.copyWith(previewUrl: url));
    // Play the new URL
  }

  Future<bool> getStatus({required String idUser}) async {
    return await authRepository.getStatusUser(idUser: idUser);
  }

  Future<void> startAccelerate() async {
    final result = await userRepository.startAccelerate();
    if (result == "0") {
      navigator.openPayment();
    }
  }

  Future<void> changeDirection({required CardSwiperDirection direction}) async {
    emit(state.copyWith(direction: direction));
  }
  void emitState(SpotifySwipeState state) {
    emit(state);
  }

  void goToDetailUser(UserEntity userEntity) {
    navigator.goToDetailProfile(userEntity);
  }
}
