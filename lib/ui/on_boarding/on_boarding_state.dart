part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  final LoadStatus loadDataStatus;
  final int index;
  const OnBoardingState({
    this.loadDataStatus = LoadStatus.initial,
    this.index = 0
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        index
      ];

  OnBoardingState copyWith({
    LoadStatus? loadDataStatus,
    int? index
  }) {
    return OnBoardingState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      index: index ?? this.index
    );
  }

}
