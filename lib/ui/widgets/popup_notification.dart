import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:chat_app/ui/home_screen/widgets/photo_card.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../app.dart';
import '../../config/helpers/helpers_data_user.dart';
import '../../generated/l10n.dart';
import '../profile_screen/widgets/bottom_modal_fullscreen.dart';

class AppPopupNotification {
  static dialogExitApp(
      {required BuildContext context,
      required String content,
      required Function() onExit}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child: Image.asset(
                'ic_tinder_logo'.withImage(),
                width: 100,
              )),
              SizedBox(height: 20.h),
              Text(
                S.current.titleDialogExit,
                style:
                    TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                content,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: const Color(0xFFE94057),
                    ),
                    child: Text(
                      S.current.textStayDialogExit,
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: onExit,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(color: Colors.grey.shade400, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      S.current.textLeaveDialogExit,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  static dialogGetLocation(
      {required BuildContext context, required Function() onChangeLocation}) {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'ic_tinder_logo'.withImage(),
                    width: 90.h,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    S().notificationDialogLocation,
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: onChangeLocation,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: const Color(0xFFE94057),
                        ),
                        child: Text(
                          S().textConfirmDialogLocation,
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: Colors.grey.shade100,
                        ),
                        child: Text(
                          S().textCancelDialogLocation,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        S().textTitleDialogLocation,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        S().textContentDialogLocation,
                        style: TextStyle(fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }

  static dialogCheckInternet({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'no_internet'.withImage(),
                  width: 150,
                ),
                SizedBox(height: 20.h),
                Text(
                  S().titleNoInternet,
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  S().contentNoInternet,
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (internetCheck == false) {
                          Future.delayed(const Duration(seconds: 5),() {
                              AppPopupNotification.dialogCheckInternet(context: context);
                          });

                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor: const Color(0xFFE94057),
                      ),
                      child: Text(
                        S.current.textButtonRetryInternet,
                        style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static dialogErrorSystem(
      {required BuildContext context,
      required String content,
      required Function() onTryAgain}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(25),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              content,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    onTryAgain();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFd73730),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S().textButtonDialogLocation,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      showCloseIcon: false,
    ).show();
  }

  static showMatchDialog(BuildContext context, {required UserEntity user,required TextEditingController textMatchController ,required ConfettiController controller}) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        controller.play();
        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: true,
          body: Container(
            decoration: const BoxDecoration(
                color: Colors.white
            ),
            width:MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
                children: [
                  PhotoGallery(
                      user: user,
                      scrollPhysics: const AlwaysScrollableScrollPhysics(),
                      currentIndex: 0,
                      borderRadius: 0,
                    ),
                  Positioned(
                      top: 30,
                      left: 10,
                      child: InkWell(
                        onTap: () => context.pop(),
                        child: SvgPicture.asset('delete'.withIcon(),),
                      )),
                  IgnorePointer(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        width:MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.6),
                              Colors.black.withOpacity(0.8),
                              Colors.black.withOpacity(1),
                            ],
                            stops: const [0.0, 0.4, 0.6, 0.8, 1.0],
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          /*  Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                     controller: textMatchController,
                                      decoration: InputDecoration(
                                        hintText:S().hintTextDialogMatch,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      controller.play();
                                    },
                                    child: Text(
                                      S().sendTextDialogMatch,
                                      style: const TextStyle(color: Colors.black,fontSize: 17, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:   SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Wrap(
                          spacing: 10,
                          children:  List.generate(HelpersDataUser.emojiDialogMatch.length, (index) {
                            final item = HelpersDataUser.emojiDialogMatch[index];
                            return  InkWell(
                              onTap: (){
                                controller.play();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width:  1,
                                    color:  Colors.grey.shade300,
                                  ),
                                ),
                                child: Text(item, style: const TextStyle(fontSize: 18,),textAlign: TextAlign.center,),
                              ),
                            );
                          }),
                        )
                    ),
                  ),
                  IgnorePointer (
                    child: Center(
                      child: Image.asset('icon-match'.withIconPNG(),fit: BoxFit.cover,),
                    ),
                  ),
                  IgnorePointer(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConfettiWidget(
                        confettiController: controller,
                        blastDirection: pi / 2,
                        emissionFrequency: 0.2,
                        numberOfParticles: 20,
                        blastDirectionality: BlastDirectionality.explosive,
                      ),
                    ),
                  ),
                ]
            ),
          ),

        );
      },
    );
  }

  static void showBottomModalVip({
    required BuildContext context,
    required Color color,
    Color? iconColor,
    bool? isHaveColor,
    bool? isHaveIcon,
    bool? isSuperLike,
    IconData? iconData,
    String? assetsBanner,
    String? assetsIcon,
    List<PackageModel>? packageModel,
    required String subTitle,
    required String title,
  }) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    EdgeInsets padding = mediaQueryData.padding;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {

        return BottomModalFullScreen(
          packageModel: packageModel,
          color: color,
          assetsBanner: assetsBanner,
          assetsIcon: assetsIcon,
          title: title,
          subTitle: subTitle,
          iconColor: iconColor,
          isHaveColor: isHaveColor ?? false,
          isHaveIcon: isHaveIcon ?? false,
          iconData: iconData,
          isSuperLike: isSuperLike ?? false,
        );
      },
    );
  }

  static showDialogComplete(BuildContext context, {required String content, required Function() onSubmit}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              Image.asset(
                'ic_tinder_logo'.withImage(),
                width: 100,
              ),

              const SizedBox(height: 20),
              Text(
                content,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: onSubmit,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: const Color(0xFFE94057),
                    ),
                    child: Text( S().highlightConfirmButton,
                      style: const TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }


}


