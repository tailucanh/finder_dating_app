import 'dart:io';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../generated/l10n.dart';
import '../../model/entities/spotify_information_entity.dart';
import 'update_profile_navigator.dart';
part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileNavigator navigator;
  final userRepository = getIt<UserRepository>();

  UpdateProfileCubit({
    required this.navigator,
  }) : super(const UpdateProfileState());

  Future<void> loadInitialData(UserEntity user) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
          gender: user.gender,
          datingPurpose: user.datingPurpose,
          school: user.school,
          introduceYourself: user.introduceYourself,
          photoList: user.photoList,
          interestsList: user.interestsList,
          fluentLanguageList: user.fluentLanguageList,
          company: user.company,
          currentAddress: user.currentAddress,
          zodiac: user.zodiac,
          height: user.height,
          academicLever: user.academicLever,
          communicateStyle: user.communicateStyle,
          languageOfLove: user.languageOfLove,
          familyStyle: user.familyStyle,
          personalityType: user.personalityType,
          myPet: user.myPet,
          drinkingStatus: user.drinkingStatus,
          smokingStatus: user.smokingStatus,
          sportsStatus: user.sportsStatus,
          eatingStatus: user.eatingStatus,
          socialNetworkStatus: user.socialNetworkStatus,
          sleepingHabits: user.sleepingHabits,
          spotifyInformation: user.spotify,
      ));

    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void updateState(UpdateProfileState state) {
    emit(state);
  }


  Future<void> updateProfile({
    int? gender,
    int? datingPurpose,
    String? school,
    String? introduceYourself,
    List<String>? photoList,
    List<int>? interestsList,
    List<String>? fluentLanguageList,
    String? company,
    String? currentAddress,
    int? height,
    //BasicInfoUser
    int? zodiac,
    int? academicLever,
    int? communicateStyle,
    int? languageOfLove,
    int? familyStyle,
    String? personalityType,

    //StyleOfLifeUser
    int? myPet,
    int? drinkingStatus,
    int? smokingStatus,
    int? sportsStatus,
    int? eatingStatus,
    int? socialNetworkStatus,
    int? sleepingHabits,
    SpotifyInformationEntity? spotifyInformation,
  }) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      await userRepository.updateUserProfile(
          gender: gender ?? state.gender!,
          datingPurpose: datingPurpose ?? state.datingPurpose!,
          school: school ?? state.school,
          introduceYourself: introduceYourself ?? state.introduceYourself,
          photoList: photoList ?? state.photoList!,
          interestsList: interestsList ?? state.interestsList!,
          fluentLanguageList: fluentLanguageList ?? state.fluentLanguageList,
          company: company ?? state.company,
          currentAddress: currentAddress ?? state.currentAddress,
          zodiac: zodiac ?? state.zodiac,
          height: height ?? state.height,
          academicLever: academicLever ?? state.academicLever,
          communicateStyle: communicateStyle ?? state.communicateStyle,
          languageOfLove: languageOfLove ?? state.languageOfLove,
          familyStyle: familyStyle ?? state.familyStyle,
          personalityType: personalityType ?? state.personalityType,
          myPet: myPet ?? state.myPet,
          drinkingStatus: drinkingStatus ?? state.drinkingStatus,
          smokingStatus: smokingStatus ?? state.smokingStatus,
          sportsStatus: sportsStatus ?? state.sportsStatus,
          eatingStatus: eatingStatus ?? state.eatingStatus,
          socialNetworkStatus: socialNetworkStatus ?? state.socialNetworkStatus,
          sleepingHabits: sleepingHabits ?? state.sleepingHabits,
          spotifyInformation: spotifyInformation ?? state.spotifyInformation
      );
      await getUserProfileFromRemote();
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> getUserProfileFromRemote() async {
    final user = await userRepository.getUserProfile();
    await loadInitialData(user);
  }

  Future<void> pickImages({required BuildContext context}) async {
    List<XFile>? resultList = await ImagePicker().pickMultiImage();
    List<File> selectedImages = resultList.map((xFile) => File(xFile.path)).toList();
    if  ((state.photoList ?? []).length + selectedImages.length <= 6) {
      for(var imageFile in selectedImages){
        await _cropImage(context: context,imageFile: imageFile);
      }
    } else {
      // Xử lý khi vượt quá số lượng ảnh tối đa
    }
    }

  Future<File?> _cropImage({required BuildContext context, required File imageFile}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 100,
      maxWidth: 500,
      maxHeight: 500,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: S().textAppBarCropPhoto ,
          toolbarColor: const Color.fromRGBO(234, 64, 128, 1),
          toolbarWidgetColor: Colors.white,
          statusBarColor: const Color.fromRGBO(234, 64, 128, 1),
          backgroundColor: Colors.white,
        ),
        IOSUiSettings(
          title: S().textAppBarCropPhoto ,
        ),
      ],
    );
    if (croppedFile != null) {
      File? croppedImage = File(croppedFile.path);
      if (croppedImage.existsSync()) {
        String fileUrl = await pushImage(croppedImage, helpersFunctions.idUser);
        (state.photoList ?? []).add(fileUrl);
        updateProfile(photoList: state.photoList);
        emit(state.copyWith(photoList: state.photoList));
      }
    }
    return null;
  }


  void removeImageFromList({required int index}) {
    (state.photoList ?? []).removeAt(index);
    updateProfile(photoList:  state.photoList);
    emit(state.copyWith(photoList: state.photoList));
    if ((state.photoList ?? []).length == 1) {
      emit(state.copyWith(photoList: state.photoList));
    }
  }


  Future<String> pushImage(File? image, String uid) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      await storageRef.child('images/$uid').putFile(image!);
      return storageRef.child('images/$uid').getDownloadURL();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    final ref = FirebaseStorage.instance.refFromURL(imageUrl);
    await ref.delete().then((_) {
      print('Image deleted successfully.');
    }).catchError((error) {
      print('Failed to delete image: $error');
    });
  }



}
