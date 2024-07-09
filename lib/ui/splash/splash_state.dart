part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final LoadStatus loadDataStatus;

  const SplashState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  SplashState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return SplashState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
