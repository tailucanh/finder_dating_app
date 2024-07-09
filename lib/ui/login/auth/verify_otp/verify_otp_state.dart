part of 'verify_otp_cubit.dart';

class VerifyOtpState extends Equatable {
  final LoadStatus loadDataStatus;

  const VerifyOtpState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  VerifyOtpState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return VerifyOtpState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
