import 'dart:io';

import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'create_story_navigator.dart';

part 'create_story_state.dart';

class CreateStoryCubit extends Cubit<CreateStoryState> {
  final CreateStoryNavigator navigator;
  final userRepository = getIt<UserRepository>();

  CreateStoryCubit({
    required this.navigator,
  }) : super(const CreateStoryState());

  Future<void> createVideoStory({File? video}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final push = await userRepository.createVideo(video: video);
      emit(state.copyWith(loadDataStatus: LoadStatus.success, success: push));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
