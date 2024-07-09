part of 'detail_profile_user_cubit.dart';

class DetailProfileUserState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus reportStatus;
  final UserEntity? user;
  final GeoPoint? locationUser;
  final bool? isMatched;
  final bool report;
  final bool isProfileVerified;

  const DetailProfileUserState(
      {this.loadDataStatus = LoadStatus.initial,
      this.reportStatus = LoadStatus.initial,
      this.user,
      this.locationUser,
      this.isProfileVerified = false,
      this.report = false,
      this.isMatched = false});

  DetailProfileUserState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? reportStatus,
    UserEntity? user,
    GeoPoint? locationUser,
    bool? isMatched,
    bool? report,
    bool? isProfileVerified
  }) {
    return DetailProfileUserState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        user: user ?? this.user,
        report: report ?? this.report,
        reportStatus: reportStatus ?? this.reportStatus,
        locationUser: locationUser ?? this.locationUser,
        isMatched: isMatched ?? this.isMatched,
        isProfileVerified: isProfileVerified ?? this.isProfileVerified
    );
  }

  @override
  List<Object?> get props =>
      [user, loadDataStatus, locationUser, reportStatus, report, isMatched,isProfileVerified];
}
