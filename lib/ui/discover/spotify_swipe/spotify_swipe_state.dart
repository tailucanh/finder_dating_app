import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../../model/entities/user_entity.dart';
import '../../../model/enums/load_state.dart';

class SpotifySwipeState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus followStatus;
  final List<UserEntity>? listUser;
  final UserEntity? userMatch;
  final List<GeoPoint>? locationUser;
  final bool locationCheck;
  final bool checkFollower;
  final String? previewUrl;
  final int? songDurationInMillisecond;
  final bool? isPlaying;

  final CardSwiperDirection direction;

  const SpotifySwipeState({
    this.loadDataStatus = LoadStatus.initial,
    this.followStatus = LoadStatus.initial,
    this.listUser,
    this.locationUser,
    this.isPlaying,
    this.userMatch,
    this.songDurationInMillisecond,
    this.checkFollower = false,
    this.locationCheck = false,
    this.direction = CardSwiperDirection.none,
    this.previewUrl,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        listUser,
        userMatch,
        locationUser,
        checkFollower,
        direction,
        locationCheck,
        followStatus,
        previewUrl,
        isPlaying,
        songDurationInMillisecond
      ];

  SpotifySwipeState copyWith(
      {LoadStatus? loadDataStatus,
      LoadStatus? followStatus,
      bool? checkFollower,
      List<UserEntity>? listUser,
      UserEntity? userMatch,
      List<GeoPoint>? locationUser,
      bool? locationCheck, bool? isPlaying,
      int? songDurationInMillisecond,
      String? previewUrl,
      CardSwiperDirection? direction}) {
    return SpotifySwipeState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        direction: direction ?? this.direction,
        userMatch: userMatch ?? this.userMatch,
        locationUser: locationUser ?? this.locationUser,
        isPlaying: isPlaying ?? this.isPlaying,
        checkFollower: checkFollower ?? this.checkFollower,
        followStatus: followStatus ?? this.followStatus,
        locationCheck: locationCheck ?? this.locationCheck,
        previewUrl: previewUrl ?? this.previewUrl,
        songDurationInMillisecond: songDurationInMillisecond ?? this.songDurationInMillisecond,
        listUser: listUser ?? this.listUser);
  }
}
