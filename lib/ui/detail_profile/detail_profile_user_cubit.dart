import 'package:bloc/bloc.dart';
import 'package:chat_app/ui/detail_profile/detail_profile_user_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../config/helpers/helpers_database.dart';
import '../../di/network_repository.dart';
import '../../model/entities/user_entity.dart';
import '../../model/enums/load_state.dart';
import '../../repositories/user_repository.dart';

part 'detail_profile_user_state.dart';

class DetailProfileUserCubit extends Cubit<DetailProfileUserState> {
  final DetailProfileNavigator navigator;
  final userRepository = getIt<UserRepository>();

  DetailProfileUserCubit({
    required this.navigator,
  }) : super(const DetailProfileUserState());

  Future<void> loadInitialData({String? id}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      final location = await userRepository.getLocationUserById(id: id);
      final isMatched = await userRepository.checkFollow(id ?? "", helpersFunctions.idUser);
      final isProfileVerified = await userRepository.checkVerificationById(id: id ?? '');
      
      emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
          locationUser: location,
          isMatched: isMatched,
          isProfileVerified: isProfileVerified
      ));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> reportUser({String? idUser, String? content}) async {
    emit(state.copyWith(reportStatus: LoadStatus.loading));
    try {
      final report =
          await userRepository.reportUser(id: idUser, content: content);
      emit(state.copyWith(reportStatus: LoadStatus.success, report: report));
    } catch (e) {
      emit(state.copyWith(reportStatus: LoadStatus.failure));
    }
  }


}
