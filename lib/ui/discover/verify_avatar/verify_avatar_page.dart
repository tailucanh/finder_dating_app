import 'package:camera/camera.dart';
import 'package:chat_app/app/app_config.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/ui/discover/verify_avatar/camera_view.dart';
import 'package:chat_app/ui/login/widgets/button_submit_page_view.dart';
import 'package:chat_app/ui/widgets/popup_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class VerifyAvatarPage extends StatefulWidget {
  const VerifyAvatarPage({super.key});

  @override
  State<VerifyAvatarPage> createState() => _VerifyAvatarPageState();
}

class _VerifyAvatarPageState extends State<VerifyAvatarPage> {
  FaceDetector faceDetector = FaceDetector(
      options: FaceDetectorOptions(
          enableContours: true, enableClassification: true));

  bool canProcess = true;
  bool isBusy = false;
  CustomPaint? customPaint;
  String? text;
  bool isLoading = false;
  int foundFaces = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [_buildMainContent(), if (isLoading) _buildLoading()],
      ),
    );
  }

  @override
  void dispose() {
    faceDetector.close();
    super.dispose();
  }

  Widget _buildMainContent() {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: [
        CameraView(
          title: '',
          onImage: (InputImage inputImage) {
            processImage(inputImage);
          },
          initialDirection: CameraLensDirection.front,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                "${S().verifyAvatarPageTitle}: ${text ?? "0"}",
                style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600, color: Colors.black),
              )),
        ),
        if (customPaint != null) customPaint!,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30,),
            onPressed: () {
              context.pop();
            },
          ),
        ),

      ]),
    );
  }

  Widget _buildLoading() {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        children: [
          // Nền mờs
          Opacity(
            opacity: 0.7,
            child: ModalBarrier(
              dismissible: false,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          // Loading Indicator
          Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: const Color(0xFFd73730),
              size: 70,
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ButtonSubmitPageView(
        text: S().verifyAvatarPageTitle_Button, color: Colors.transparent,
        onPressed: () async {
          setState(() {
            isLoading = true;
          });

          if (foundFaces == 1) {
            await FirebaseFirestore.instance
                .collection(AppConfig.tableTokens)
                .doc(helpersFunctions.idUser)
                .update({
              'isProfileVerified': true,
            }).then((value) {
              setState(() {
                isLoading = false;
              });
              AppPopupNotification.showDialogComplete(context,
                  content: S().verifyAvatarPageContent_Success, onSubmit: () {
                    context.pop();
                    context.pop();
                  });
            });
          } else {
            AppPopupNotification.dialogErrorSystem(
                content: S().verifyAvatarPageContent_Fall,
                context: context,
                onTryAgain: () {});
            isLoading = false;
          }
        },
      ),
    );
  }

  Future processImage(InputImage inputImage) async {
    if (!canProcess) return;
    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      // final painter = FaceDetectorPainter(faces, inputImage.metadata!.size,
      //     inputImage.metadata!.rotation, CameraLensDirection.front);
      // customPaint = CustomPaint(
      //   painter: painter,
      // );
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (!mounted) return;
    if (faces.isNotEmpty) {
      setState(() {
        foundFaces = faces.length;
        text = faces.length.toString();
      });
    } else {
      setState(() {
        text = "0";
      });
    }
  }
}
