import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../config/helpers/helpers_database.dart';
import '../../../di/network_repository.dart';
import '../../../generated/l10n.dart';
import 'create_acc_navigator.dart';

part 'create_acc_state.dart';

class CreateAccCubit extends Cubit<CreateAccState> {
  final CreateAccNavigator navigator;
  final authRepository = getIt<AuthRepository>();

  CreateAccCubit({
    required this.navigator,
  }) : super(const CreateAccState());

  Future<void> createAccount(
      {String? email,
      String? phone,
      String? fullName,
      String? birthday,
      String? avatar,
      int? gender,
      int? requestToShow,
      int? datingPurpose,
      String? introduceYourself,
      List<File>? photoList,
      List<int>? interestsList,
      String? currentAddress,
      String? accessToken,
      String? idToken}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    final idUser = const Uuid().v1();
    List<String> urlImages = [];
    urlImages = await pushListImage(photoList ?? [], idUser);
    try {
      final value = await authRepository.createAccount(
          userEntity: UserEntity(
            uid: idUser,
            uidCall: math.Random().nextInt(100000000).toString(),
            email: email ?? "",
            phone: phone ?? "",
            fullName: fullName ?? "",
            birthday: birthday ?? "",
            avatar: urlImages[0] ?? "",
            gender: gender ?? 0,
            requestToShow: requestToShow ?? 0,
            datingPurpose: datingPurpose ?? 0,
            introduceYourself: introduceYourself ?? "",
            school: "",
            followersList: [],
            photoList: urlImages ?? [],
            interestsList: interestsList ?? [],
            fluentLanguageList: [],
            sexualOrientationList: [],
            likeList: [],
            disLikeList: [],
            company: "",
            currentAddress: currentAddress ?? "",
            activeStatus: false,
            height: 0,
            academicLever: -1,
            communicateStyle: -1,
            drinkingStatus: -1,
            eatingStatus: -1,
            familyStyle: -1,
            languageOfLove: -1,
            personalityType: "",
            sleepingHabits: -1,
            smokingStatus: -1,
            socialNetworkStatus: -1,
            sportsStatus: -1,
            zodiac: -1,
            myPet: -1,
          ),
          accessToken: accessToken,
          idToken: idToken);
      helpersFunctions.idUser = idUser;
      if (value == "1") {
        navigator.openPage();
      }
      emit(state.copyWith(
          loadDataStatus: LoadStatus.success, loadingState: value));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  changePage({required int indexPage}) async {
    emit(state.copyWith(indexPage: indexPage));
  }

  changeName({required String name}) async {
    emit(state.copyWith(fullName: name));
  }

  changeBirthday({required String birthday}) async {
    emit(state.copyWith(birthday: birthday));
  }

  changeGender({required int gender}) async {
    emit(state.copyWith(gender: gender));
  }

  changeRequest({required int request}) async {
    emit(state.copyWith(requestGender: request));
  }

  changeDatingPurpose({required int datingPurpose}) async {
    emit(state.copyWith(datingPurpose: datingPurpose));
  }

  changeInterests({required List<int> interests}) async {
    emit(state.copyWith(interests: interests));
  }

  changePhotos({required List<File> photoList}) async {
    emit(state.copyWith(photoList: photoList));
  }

  changeEditingPhoto({required bool isEdit}) async {
    emit(state.copyWith(isEditingPhoto: isEdit));
  }

  Future<void> pickImages(
      {required BuildContext context, required List<File> photosList}) async {
    List<XFile>? resultList = await ImagePicker().pickMultiImage();
    List<File> selectedImages =
        resultList.map((xFile) => File(xFile.path)).toList();
    if (photosList.length + selectedImages.length <= 6) {
      for (var imageFile in selectedImages) {
        await _cropImage(imageFile: imageFile, photosList: photosList);
        emit(state.copyWith(photoList: photosList));
      }
      emit(state.copyWith(isEditingPhoto: photosList.length > 1));
    } else {
      // Xử lý khi vượt quá số lượng ảnh tối đa
    }
    }

  Future<File?> _cropImage(
      {required File imageFile, required List<File> photosList}) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        compressQuality: 100,
        maxWidth: 500,
        maxHeight: 500,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: S().textAppBarCropPhoto,
            toolbarColor: const Color.fromRGBO(234, 64, 128, 1),
            toolbarWidgetColor: Colors.white,
            statusBarColor: const Color.fromRGBO(234, 64, 128, 1),
            backgroundColor: Colors.white,
          ),
          IOSUiSettings(
            title: S().textAppBarCropPhoto,
          ),
        ],
      );

      if (croppedFile != null) {
        File? croppedImage = File(croppedFile.path);
        if (croppedImage.existsSync()) {
          photosList.add(croppedImage);
        }
      }
    } on PlatformException catch (e) {
      log('Bug', error: e);
    }
    return null;
  }

  void removeImageFromList(
      {required List<File> photosList, required int index}) {
    photosList.removeAt(index);
    if (photosList.length == 1) {
      emit(state.copyWith(isEditingPhoto: false));
    }
  }

  Future<List<String>> pushListImage(List<File?> images, String uid) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final List<String> downloadURLs = [];
      const uuid = Uuid();

      for (File? image in images) {
        if (image != null) {
          final fileName = '${uuid.v4()}.${image.path.split('.').last}';
          final uploadTask =
              storageRef.child('images/$uid/$fileName').putFile(image);
          final snapshot = await uploadTask.whenComplete(() {});
          final downloadURL = await snapshot.ref.getDownloadURL();
          downloadURLs.add(downloadURL);
        }
      }
      return downloadURLs;
    } catch (e) {
      throw Exception(e);
    }
  }

/*sexualChange({required int request}) async {
    if (state.sexual == null) {
      emit(state.copyWith(sexual: [request], index: state.index + 1));
    } else {
      List<int> list = state.sexual ?? [];
      if (list.length < 3) {
        if (list.containsNumber(request)) {
          list.remove(request);
          emit(state.copyWith(sexual: list, index: state.index - 1));
        } else {
          list.add(request);
          emit(state.copyWith(sexual: list, index: state.index + 1));
        }
      } else {
        list.remove(request);
        emit(state.copyWith(sexual: list, index: state.index - 1));
      }
    }
  }*/
}
