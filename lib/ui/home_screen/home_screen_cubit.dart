import 'dart:developer';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../di/network_repository.dart';
import '../../generated/l10n.dart';
import '../../services/location_name.dart';
import 'home_screen_navigator.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final HomeScreenNavigator navigator;
  final userRepository = getIt<UserRepository>();
  final authRepository = getIt<AuthRepository>();

  HomeScreenCubit({
    required this.navigator,
  }) : super(const HomeScreenState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      final users = await userRepository.getUsers(
          userLatitude: helpersFunctions.userLatitude,
          userLongitude: helpersFunctions.userLongitude,
          radius: helpersFunctions.maxDistance);

      emit(state.copyWith(listUser: users));

      List<GeoPoint> listLocation = [];

      if ((users ?? []).isNotEmpty) {
        for (UserEntity user in users ?? []) {
          final location = await userRepository.getLocationUserById(id: user.uid);
          log("${user.fullName} ${user.uid} ${location!.latitude}  ${location.longitude} }");
          listLocation.add(location);
        }
        emit(state.copyWith(
            listUser: users,
            locationsUser: listLocation,
        ));
      }

      emit(state.copyWith(
        listUser: users,
        locationsUser: listLocation,
        loadDataStatus: LoadStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> getVipUser() async {
    try {
      final isPrimary = await userRepository.getPrimaryAcceleration();
      final turn = await userRepository.getTurnAccelerate();
      emit(state.copyWith(isVipUser: isPrimary, turnVipUser: turn));
    } catch (e) {}
  }

  Future<void> getLocation() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      await userRepository.getLocationUser();
      String? address = await getLocationCity(
          latitude: helpersFunctions.userLatitude,
          longitude: helpersFunctions.userLongitude);
      await userRepository.updateCurrentAddressUser(address: address ?? "");

      emit(state.copyWith(loadDataStatus: LoadStatus.success));
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
    emit(state.copyWith(followStatus: LoadStatus.initial));
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
              title: S().notificationMatchTitle,
              type: 'match',
              message: S().notificationMatchContent,
              uid: id);
          await userRepository.createChatsItem(uid: id);
        }
        emit(state.copyWith(
            followStatus: LoadStatus.success, checkFollower: checkFollower));
      }

    } catch (e) {
      emit(state.copyWith(
        loadDataStatus: LoadStatus.failure,
      ));
    }
  }

  Future<bool> getStatus({required String idUser}) async {
    return await authRepository.getStatusUser(idUser: idUser);
  }

  Future<void> startAccelerate() async {
    final result = await userRepository.startAccelerate();
    if (result == "0") {
      navigator.openPayment().then((value) => loadInitialData());
    }
  }

  Future<void> changeDirection({required CardSwiperDirection direction}) async {
    emit(state.copyWith(direction: direction));
  }

  void goToDetailUser(UserEntity userEntity) {
    navigator.goToDetailProfile(userEntity);
  }
}
