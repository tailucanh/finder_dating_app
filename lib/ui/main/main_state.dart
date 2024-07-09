part of 'main_cubit.dart';

class MainState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus accelerateStatus;
  final Offset? position;
  final int selectedIndex;
  final bool internetStatus;
  final bool accelerate;

  const MainState(
      {this.loadDataStatus = LoadStatus.initial,
      this.accelerateStatus = LoadStatus.initial,
      this.accelerate = false,
      this.position,
      this.selectedIndex = 0,
      this.internetStatus = true});

  @override
  List<Object?> get props => [
        loadDataStatus,
        accelerate,
        position,
        selectedIndex,
        accelerateStatus,
        internetStatus
      ];

  MainState copyWith(
      {LoadStatus? loadDataStatus,
      LoadStatus? accelerateStatus,
      bool? accelerate,
      Offset? position,
      int? selectedIndex,
      bool? internetStatus}) {
    return MainState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        internetStatus: internetStatus ?? this.internetStatus,
        accelerateStatus: accelerateStatus ?? this.accelerateStatus,
        accelerate: accelerate ?? this.accelerate,
        position: position ?? this.position,
        selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
