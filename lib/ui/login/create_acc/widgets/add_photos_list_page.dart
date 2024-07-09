import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../app.dart';
import '../../../../model/enums/load_state.dart';
import '../../../widgets/popup_notification.dart';
import '../../widgets/button_submit_page_view.dart';
import '../create_acc_cubit.dart';

class AddPhotoListPageSection extends StatefulWidget {
  final Map<String, dynamic> authentication;
  const AddPhotoListPageSection({super.key, required this.authentication});
  @override
  State<AddPhotoListPageSection> createState() =>
      _AddPhotoListPageSectionChildPageState();
}

class _AddPhotoListPageSectionChildPageState
    extends State<AddPhotoListPageSection> {
  List<File> photosListFile = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 210) / 2;
    final double itemWidth = size.width / 2;
    return BlocBuilder<CreateAccCubit, CreateAccState>(
      builder: (context, state) {
        if (state.photoList != null) {
          photosListFile = state.photoList ?? [];
        }

        return state.loadDataStatus == LoadStatus.loading
            ? Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  color: const Color(0xFFd73730),
                  size: 70,
                ),
              )
            : Scaffold(
                extendBody: true,
                bottomNavigationBar: BottomAppBar(
                  elevation: 0,
                  color: Colors.transparent,
                  child: ButtonSubmitPageView(
                      text: S().textNextButton,
                      color: (photosListFile.length >= 2)
                          ? Colors.transparent
                          : Colors.grey,
                      onPressed: () {
                        if (internetCheck == false) {
                          AppPopupNotification.dialogCheckInternet(
                              context: context);
                        } else {
                          (photosListFile.length >= 2)
                              ? BlocProvider.of<CreateAccCubit>(context)
                                  .createAccount(
                                  phone: "",
                                  email: widget.authentication['email'],
                                  fullName: state.fullName,
                                  gender: state.gender,
                                  birthday: state.birthday,
                                  datingPurpose: state.datingPurpose,
                                  interestsList: state.interests,
                                  requestToShow: state.requestGender,
                                  photoList: photosListFile,
                                  accessToken:
                                      widget.authentication['accessToken'],
                                  idToken: widget.authentication['idToken'],
                                )
                              : null;
                        }
                      }),
                ),
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height / 1.16,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S().titleAddPhotosPage,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 25),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              S().textContentPhotos,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.65,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 4,
                              childAspectRatio: itemWidth / itemHeight,
                            ),
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              if (index < photosListFile.length) {
                                return Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Image.file(
                                        photosListFile[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () {
                                        state.isEditingPhoto
                                            ? BlocProvider.of<CreateAccCubit>(
                                                    context)
                                                .removeImageFromList(
                                                    photosList: photosListFile,
                                                    index: index)
                                            : BlocProvider.of<CreateAccCubit>(
                                                    context)
                                                .pickImages(
                                                    context: context,
                                                    photosList: photosListFile);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          state.isEditingPhoto
                                              ? Icons.close_rounded
                                              : Icons.edit,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]);
                              } else {
                                return InkWell(
                                  onTap: () {
                                    BlocProvider.of<CreateAccCubit>(context)
                                        .pickImages(
                                            context: context,
                                            photosList: photosListFile);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: DottedBorder(
                                      strokeWidth: 3,
                                      borderType: BorderType.RRect,
                                      color: Colors.grey.shade500,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.grey.shade200
                                              : Colors.black,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
