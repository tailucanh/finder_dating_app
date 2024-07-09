part of 'create_acc_cubit.dart';

class CreateAccState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? loadingState;
  final int index;
  final int indexPage;
  final String birthday;
  final String fullName;
  final int gender;
  final int requestGender;
  final int datingPurpose;
  final List<int>? interests;
  final List<File>? photoList;
  final bool isEditingPhoto;

  const CreateAccState(
      {this.loadDataStatus = LoadStatus.initial,
      this.indexPage = 0,
      this.datingPurpose = 0,
      this.loadingState,
      this.birthday = '',
      this.fullName = '',
      this.index = 0,
      this.interests,
      this.photoList,
      this.isEditingPhoto = false,
      this.requestGender = 0,
      this.gender = 0});

  @override
  List<Object?> get props => [
        loadDataStatus,
        indexPage,
        index,
        fullName,
        birthday,
        gender,
        requestGender,
        interests,
        photoList,
        isEditingPhoto,
        datingPurpose,
        loadingState
      ];

  CreateAccState copyWith(
      {LoadStatus? loadDataStatus,
      int? indexPage,
      int? datingPurpose,
      int? index,
      String? fullName,
      String? birthday,
      List<int>? interests,
      List<File>? photoList,
      bool? isEditingPhoto,
      int? gender,
      String? loadingState,
      int? requestGender}) {
    return CreateAccState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        gender: gender ?? this.gender,
        index: index ?? this.index,
        fullName: fullName ?? this.fullName,
        birthday: birthday ?? this.birthday,
        datingPurpose: datingPurpose ?? this.datingPurpose,
        interests: interests ?? this.interests,
        photoList: photoList ?? this.photoList,
        isEditingPhoto: isEditingPhoto ?? this.isEditingPhoto,
        loadingState: loadingState ?? this.loadingState,
        requestGender: requestGender ?? this.requestGender,
        indexPage: indexPage ?? this.indexPage);
  }
}
