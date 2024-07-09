part of 'home_screen_cubit.dart';

class HomeScreenState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus followStatus;
  final LoadStatus primaryState;
  final List<UserEntity>? listUser;
  final List<GeoPoint>? locationsUser;
  final UserEntity? userMatch;
  final bool locationCheck;
  final bool checkFollower;
  final CardSwiperDirection direction;
  final bool isVipUser;
  final int turnVipUser;

  const HomeScreenState(
      {this.loadDataStatus = LoadStatus.initial,
      this.primaryState = LoadStatus.initial,
      this.followStatus = LoadStatus.initial,
      this.listUser,
      this.locationsUser,
      this.userMatch,
      this.turnVipUser = 0,
      this.checkFollower = false,
      this.isVipUser = false,
      this.locationCheck = false,
      this.direction = CardSwiperDirection.none});

  @override
  List<Object?> get props => [
        loadDataStatus,
        listUser,
        primaryState,
        userMatch,
        isVipUser,
        locationsUser,
        turnVipUser,
        checkFollower,
        direction,
        locationCheck,
        followStatus
      ];

  HomeScreenState copyWith(
      {LoadStatus? loadDataStatus,
      LoadStatus? followStatus,
      LoadStatus? primaryState,
      bool? checkFollower,
      bool? isVipUser,
      List<GeoPoint>? locationsUser,
      int? turnVipUser,
      List<UserEntity>? listUser,
      UserEntity? userMatch,
      bool? locationCheck,
      CardSwiperDirection? direction}) {
    return HomeScreenState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        direction: direction ?? this.direction,
        primaryState: primaryState ?? this.primaryState,
        isVipUser: isVipUser ?? this.isVipUser,
        userMatch: userMatch ?? this.userMatch,
        locationsUser: locationsUser ?? this.locationsUser,
        turnVipUser: turnVipUser ?? this.turnVipUser,
        checkFollower: checkFollower ?? this.checkFollower,
        followStatus: followStatus ?? this.followStatus,
        locationCheck: locationCheck ?? this.locationCheck,
        listUser: listUser ?? this.listUser);
  }
}
