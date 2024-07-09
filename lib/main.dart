import 'dart:async';

import 'package:camera/camera.dart';
import 'package:chat_app/app.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/services/notification_controller.dart';
import 'package:chat_app/services/purchase_api.dart';
import 'package:chat_app/services/time_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'di/network_repository.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart';


List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  ZegoUIKitPrebuiltCallInvitationService()
      .setNavigatorKey(AppRoutes.navigationKey);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());
  timeService = TimeService();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  await ScreenUtil.ensureScreenSize();
  configureInjection();

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService()
        .useSystemCallingUI([ZegoUIKitSignalingPlugin()]);
  });
  await PurchaseApi.init();
  runApp(
    const MyApp(),
  );
}

