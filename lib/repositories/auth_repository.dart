
import 'package:chat_app/app/app_config.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/services/call_video_service.dart';
import 'package:chat_app/services/time_service.dart';
import 'package:chat_app/ui/login/auth/phone/login_phone_navigator.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

abstract class AuthRepository {
  Future<String?> loginPhone(
      String codeCountry, numberPhone, LoginPhoneNavigator navigator);

  Future<GoogleSignInAccount?>? loginGoogle();

  Future<void> logout();

  Future<void> changedStatus({required bool status});

  Future<bool> getStatusUser({required String idUser});

  Future<void> timeActive({int? time});

  Future<bool> checkLogin();

  Future<String>? checkAuth(
      {String? email, String? accessToken, String? idToken});

  Future<String> createAccount(
      {required UserEntity userEntity, String? accessToken, String? idToken});

  Future<void> logoutGoogle({String? accessToken, String? idToken});
}

class AuthRepositoryImpl extends AuthRepository {
  final Dio dio;
  FirebaseFirestore database = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthRepositoryImpl({required this.dio, required this.database});

  @override
  Future<void> logout() async {
    try {
      await changedStatus(status: false);
      helpersFunctions.userLongitude = 0.0;
      helpersFunctions.userLatitude = 0.0;
      helpersFunctions.lastFetchedTimestamp = 0.0;
      helpersFunctions.idUser = '';
      helpersFunctions.timeEnd = '0';
      helpersFunctions.timeStart = '0';

      await auth.signOut();
      await GoogleSignIn().signOut();
      onUserLogout();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<String?> loginPhone(
      String codeCountry, numberPhone, LoginPhoneNavigator navigator) async {
    String? result;
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: '$codeCountry $numberPhone',
          timeout: const Duration(minutes: 2),
          verificationCompleted: (PhoneAuthCredential credential) async {
            result = credential.verificationId;
            await auth
                .signInWithCredential(credential)
                .then((value) => navigator.openCreateAcc());
          },
          verificationFailed: (FirebaseAuthException e) {
            result = '';
          },
          codeSent: (String verificationId, int? resendToken) {
            result = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            result = verificationId;
          });
    } on FirebaseException {
      result = null;
    }
    return result;
  }

  @override
  Future<GoogleSignInAccount?> loginGoogle() async {
    final googleSignIn = await GoogleSignIn().signIn();
    if (googleSignIn != null) {
      return googleSignIn;
    }
    return null;
  }

  @override
  Future<String> createAccount(
      {required UserEntity userEntity,
      String? accessToken,
      String? idToken}) async {
    try {
      final ggLogin = GoogleAuthProvider.credential(
          accessToken: accessToken, idToken: idToken);

      await auth.signInWithCredential(ggLogin).then((value) async {
        ZegoUIKitPrebuiltCallInvitationService().init(
          appID: AppConfig.yourAppID,
          /*input your AppID*/
          appSign: AppConfig.yourAppSign /*input your AppSign*/,
          userID: userEntity.uidCall,
          userName: userEntity.fullName,
        /*  androidNotificationConfig: ZegoAndroidNotificationConfig(
            channelID: "ZegoUIKit",
            channelName: "Call Notifications",
            sound: "notification",
            icon: "notification_icon",
          ),*/
          plugins: [ZegoUIKitSignalingPlugin()],
        );
        await database
            .collection(AppConfig.tableUser)
            .doc(userEntity.uid)
            .set(userEntity.toJson());
      });
      return "1";
    } on FirebaseException {
      return '0';
    }
  }

  @override
  Future<String>? checkAuth(
      {String? email, String? accessToken, String? idToken}) async {
    try {
      String? check;
      await database
          .collection(AppConfig.tableUser)
          .where('email', isEqualTo: email ?? "")
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          check = "1";
          final acc = await database.collection(AppConfig.tableAccelerate).doc(value.docs.first.id).get();
          helpersFunctions.idUser = value.docs.first.id;
          helpersFunctions.fullName = value.docs.first.data()['fullName'];
          helpersFunctions.callId = value.docs.first.data()['uidCall'];
          helpersFunctions.timeEnd = acc.data()?['timeEnd'];
          helpersFunctions.timeStart = acc.data()?['timeStart'];
          helpersFunctions.requestToShow =
              value.docs.first.data()['requestToShow'];

          final ggLogin = GoogleAuthProvider.credential(
              accessToken: accessToken, idToken: idToken);

          await auth.signInWithCredential(ggLogin);
        }
      });
      return check ?? '0';
    } on FirebaseException {
      return '0';
    }
  }

  @override
  Future<void> logoutGoogle({String? accessToken, String? idToken}) async {
    try {
      await auth.signOut();
      await GoogleSignIn().signOut();
    } on FirebaseException {}
  }

  @override
  Future<bool> checkLogin() async {
    try {
      if (auth.currentUser != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException {
      return false;
    }
  }

  @override
  Future<void> changedStatus({required bool status}) async {
    try {
      await database
          .collection(AppConfig.tableTokens)
          .doc(helpersFunctions.idUser)
          .update({
        'timeActive': timeService.timeNow.millisecondsSinceEpoch
      }).then((value) => database
              .collection(AppConfig.tableUser)
              .doc(helpersFunctions.idUser)
              .update({'activeStatus': status}));
    } on FirebaseException {}
  }

  @override
  Future<void> timeActive({int? time}) async {
    try {
      await database
          .collection(AppConfig.tableTokens)
          .doc(helpersFunctions.idUser)
          .update({'time': time});
    } on FirebaseException {}
  }

  @override
  Future<bool> getStatusUser({required String idUser}) async {
    try {
      bool isActive = false;
      await database
          .collection(AppConfig.tableUser)
          .doc(idUser)
          .get()
          .then((value) => () {
                if (value.data()!.isNotEmpty) {
                  isActive = value.data()!['activeStatus'] as bool;
                }
              });
      return isActive;
    } on FirebaseException {
      return false;
    }
  }
}
