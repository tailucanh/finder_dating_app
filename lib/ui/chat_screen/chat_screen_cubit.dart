import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/model/params/card_chat.dart';
import 'package:chat_app/model/params/story_card.dart';
import 'package:chat_app/repositories/chat_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../di/network_repository.dart';
import 'chat_screen_navigator.dart';

part 'chat_screen_state.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  final ChatScreenNavigator navigator;
  final chatRepository = getIt<ChatRepository>();
  final userRepository = getIt<UserRepository>();

  ChatScreenCubit({
    required this.navigator,
  }) : super(const ChatScreenState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final data = chatRepository.getAllChats();

      emit(state.copyWith(loadDataStatus: LoadStatus.success, listChat: data));
    } on FirebaseException {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }


  Future<void> loadStory() async {
    emit(state.copyWith(loadStatusStory: LoadStatus.loading));
    try {
      final data = await userRepository.getListVideo();
      emit(
          state.copyWith(loadStatusStory: LoadStatus.success, listStory: data));
    } on FirebaseException {
      emit(state.copyWith(loadStatusStory: LoadStatus.failure));
    }
  }

  Future<void> pickVideo() async {
    try {
      final videoPicker = ImagePicker();
      final video = await videoPicker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        navigator.openPage(video.path);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
