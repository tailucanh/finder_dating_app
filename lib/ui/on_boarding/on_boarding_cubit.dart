import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/enums/load_state.dart';
import 'on_boarding_navigator.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final OnBoardingNavigator navigator;

  OnBoardingCubit({
    required this.navigator,
  }) : super(const OnBoardingState(index: 0));

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
       emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
  void openPage() {
    navigator.openPage();
  }
  void onChangeIndex(i) {
    emit(state.copyWith(index: i));
  }
}
