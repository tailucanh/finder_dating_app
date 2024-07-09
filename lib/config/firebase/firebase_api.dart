import 'dart:convert';

import 'package:chat_app/config/firebase/key.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class FirebaseApi {
  static bool enablePermission = false;
  static String address = '';
  static List<String> locations = [];

  // Future<String?> checkPermissionLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return "isNotEnable";
  //   }
  //
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return "isDenied";
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return "isDeniedForever";
  //   }
  //   if (permission == LocationPermission.whileInUse ||
  //       permission == LocationPermission.always) {
  //     return "isOnlyThisTime";
  //   }
  //
  //
  //   return null;
  // }

  Future<bool> checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  Future setPermissionLocation(BuildContext context) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      context.goNamed('location-screen');
    } else if (permission == LocationPermission.deniedForever) {
      // Xử lý khi quyền bị từ chối mãi mãi
    } else {
      enablePermission = true;
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      locations.add(position.longitude.toString());
      locations.add(position.latitude.toString());

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks[0];
      if (placemark.subThoroughfare != null) {
        address += '${placemark.subThoroughfare}, ';
      }
      if (placemark.thoroughfare != null) {
        address += '${placemark.thoroughfare}, ';
      }
      if (placemark.subAdministrativeArea != null) {
        address += '${placemark.subAdministrativeArea}, ';
      }
      if (placemark.administrativeArea != null) {
        address += '${placemark.administrativeArea}, ';
      }
      if (placemark.country != null) {
        address += '${placemark.country}';
      }
      print('Địa chỉ: $placemark');
    }
  }

  Future checkPermissionNotification() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }
  }

  Future<void> sendPushMessage(
      {required String body,
      required String title,
      required String token,
      required String uid,
      required String type,
      required String chatRoomId,
      required String name,
      required String avatar}) async {
    try {
      await http.post(
        Uri.parse(API_KEY),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$KEY',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': uid,
              'chatRoomId': chatRoomId,
              'name': name,
              'type': type,
              'avatar': avatar,
              'status': 'false'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }
}
