import 'dart:io';

import 'package:chat_app/app/app_config.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/entities/accelerate.dart';
import 'package:chat_app/model/entities/chat_item.dart';
import 'package:chat_app/model/entities/notification.dart';
import 'package:chat_app/model/entities/pay_entity.dart';
import 'package:chat_app/model/entities/spotify_information_entity.dart';
import 'package:chat_app/model/entities/story.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/params/report.dart';
import 'package:chat_app/model/params/story_card.dart';
import 'package:chat_app/model/params/tokens.dart';
import 'package:chat_app/services/time_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

abstract class UserRepository {
  Future<UserEntity> getUserProfile();

  Future<void> saveToken();

  Future<bool> checkVerification();

  Future<bool> checkVerificationById({required String id});

  Future<bool> reportUser({String? id, String? reasonTitle, String? reasonDetail, String? content});

  Future<Tokens?> getTokenById({required String id});

  Future<bool> getPrimaryAcceleration();

  Future<bool> getPrimaryGold();

  Future<String?> createChatsItem({String? uid});

  Future<String?> startAccelerate();

  Future<int?> getTurnAccelerate();

  Future<void> createAccelerate({required int turn, required int priority});

  Future<bool> createVideo({File? video});

  Future<List<StoryCard>?> getListVideo();

  Future<void> createBill({required PayEntity payEntity});

  Future<void> updateUserProfile({
    required int gender,
    required int datingPurpose,
    required String? school,
    required String? introduceYourself,
    required List<String> photoList,
    required List<int> interestsList,
    required List<String>? fluentLanguageList,
    required String? company,
    required String? currentAddress,
    required int? height,

//BasicInfoUser
    required int? zodiac,
    required int? academicLever,
    required int? communicateStyle,
    required int? languageOfLove,
    required int? familyStyle,
    required String? personalityType,

    //StyleOfLifeUser
    required int? myPet,
    required int? drinkingStatus,
    required int? smokingStatus,
    required int? sportsStatus,
    required int? eatingStatus,
    required int? socialNetworkStatus,
    required int? sleepingHabits,
    required SpotifyInformationEntity? spotifyInformation,
  });

  Future<bool> getLocationUser();

  Future<void> updateCurrentAddressUser({required String address});

  Future<GeoPoint?> getLocationUserById({String? id});

  Future<List<GeoPoint>?> getLocationUserByListUser(
      {required List<UserEntity> listUser});

  Future<void> updateRequestToShow();

  Future<void> saveNotification({Data? data, String? message});

  Future<void> pushNotification(
      {String? uid, String? title, String? message, String? type});

  Future<bool?> followUser({String? uid});

  Future<List<PayEntity>?> getAllBill();

  Future<List<UserEntity>?> getTopUser();

  Future<List<UserEntity>>? getUsers(
      {required double userLatitude,
      required double userLongitude,
      required double radius});

  Future<List<UserEntity>>? getUsersTopRecentActive();

  Future<List<UserEntity>?> getUsersHaveSpotify(int requestToShow);

  Future<List<UserEntity>>? getUsersTopCommonInterest();

  Future<UserEntity?> getOneUser({String? id});

  Future<List<UserEntity>> getUserFollowers();

  Future<bool> checkFollow(String uid, String followerId);

  Future<void> removeFollow(String uid, String followerId);

  Future<void> addSpotify(SpotifyInformationEntity? spotify);
}

class UserRepositoryImpl extends UserRepository {
  FirebaseFirestore database;
  FirebaseDatabase ref;
  Dio dio;

  UserRepositoryImpl(
      {required this.database, required this.ref, required this.dio});

  @override
  Future<bool> getLocationUser() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final location = await Geolocator.getCurrentPosition();
    helpersFunctions.userLongitude = location.longitude;
    helpersFunctions.userLatitude = location.latitude;
    await database
        .collection(AppConfig.tableLocation)
        .doc(helpersFunctions.idUser)
        .set({
      'location': GeoPoint(location.latitude, location.longitude),
      "idUser": helpersFunctions.idUser
    });

    return true;
  }

  @override
  Future<GeoPoint?> getLocationUserById({String? id}) async {
    try {
      final response =
          await database.collection(AppConfig.tableLocation).doc(id).get();
      GeoPoint geoPoint = response.data()?['location'];

      return geoPoint;
    } on FirebaseException {}
    return null;
  }

  @override
  Future<List<GeoPoint>?> getLocationUserByListUser(
      {required List<UserEntity> listUser}) async {
    List<GeoPoint> listLocation = [];
    try {
      List<String> listId = listUser.map((e) => e.uid).toList();
      if (listId.isNotEmpty) {
        final data = await database
            .collection(AppConfig.tableLocation)
            .where('idUser', whereIn: listId)
            .get();
        print('listDataLocation : ${data.docs.length}');
        for (var element in data.docs) {
          listLocation.add(element.data()['location'] as GeoPoint);
        }

        return listLocation;
      }

      return listLocation;
    } on FirebaseException {}
    return listLocation;
  }

  @override
  Future<void> updateCurrentAddressUser({required String address}) async {
    try {
      await database
          .collection(AppConfig.tableUser)
          .doc(helpersFunctions.idUser)
          .update({'currentAddress': address});
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Future<List<UserEntity>>? getUsers(
      {required double userLatitude,
      required double userLongitude,
      required double radius}) async {
    try {
      // Tính toán điểm tâm và khoảng cách giới hạn dựa trên bán kính
      LatLng centerLatLng = LatLng(userLatitude, userLongitude);
      double maxDistance = radius * 1000.0; // Chuyển đổi bán kính sang mét

      QuerySnapshot<Map<String, dynamic>> response = await database
          .collection(AppConfig.tableUser)
          .where('gender', isEqualTo: helpersFunctions.requestToShow)
          .where('uid', isNotEqualTo: helpersFunctions.idUser)
          .get();

      List<String> listId =
          response.docs.map((e) => e.data()['uid'].toString()).toList();
      final locations = await database
          .collection(AppConfig.tableLocation)
          .where('idUser', whereIn: listId)
          .get();

      final sortList = quicksort(
          response.docs, 0, response.docs.length - 1, centerLatLng, locations);
      List<UserEntity> users = [];
      for (var element in sortList) {
        if (helpersFunctions.accessDistance) {
          GeoPoint geoPoint = locations.docs
              .where((e) => e.id == element.id)
              .first
              .data()['location'];

          num distance = Geodesy().distanceBetweenTwoGeoPoints(
              centerLatLng, LatLng(geoPoint.latitude, geoPoint.longitude));
          // Kiểm tra xem người dùng có nằm trong phạm vi bán kính không
          if (distance <= maxDistance) {
            if (helpersFunctions.accessAge) {
              // kiem tra xem co nam trong do tuoi yc hay khong
              if (DateTime.parse(element.data()['birthday']).isAfter(DateTime(
                      (DateTime.now().year - helpersFunctions.ageMaxToShow)
                          .toInt(),
                      0,
                      0)) &&
                  DateTime.parse(element.data()['birthday']).isBefore(DateTime(
                      (DateTime.now().year - helpersFunctions.ageMinToShow)
                          .toInt(),
                      0,
                      0))) {
                users.add(UserEntity.fromJson(element.data()));
              }
            } else {
              users.add(UserEntity.fromJson(element.data()));
            }
          }
        } else {
          if (helpersFunctions.accessAge) {
            // kiem tra xem co nam trong do tuoi yc hay khong
            if (DateTime.parse(element.data()['birthday']).isAfter(DateTime(
                    (DateTime.now().year - helpersFunctions.ageMaxToShow)
                        .toInt(),
                    0,
                    0)) &&
                DateTime.parse(element.data()['birthday']).isBefore(DateTime(
                    (DateTime.now().year - helpersFunctions.ageMinToShow)
                        .toInt(),
                    0,
                    0))) {
              users.add(UserEntity.fromJson(element.data()));
            }
          } else {
            users.add(UserEntity.fromJson(element.data()));
          }
        }
      }

      final accelerates = await database
          .collection(AppConfig.tableAccelerate)
          .where('uid', whereIn: users.map((e) => e.uid).toList())
          .get();

      users.sort(
        (a, b) {
          int priorityA = int.parse(accelerates.docs
                  .where((element) => element.id == a.uid)
                  .firstOrNull
                  ?.data()["priority"] ??
              "-1");
          int priorityB = int.parse(accelerates.docs
                  .where((element) => element.id == b.uid)
                  .firstOrNull
                  ?.data()["priority"] ??
              "-1");

          bool valueA2 = timeService.timeNow.millisecondsSinceEpoch <=
              int.parse(accelerates.docs
                      .where((element) => element.id == a.uid)
                      .firstOrNull
                      ?.data()['timeEnd'] ??
                  '0');
          bool valueB2 = timeService.timeNow.millisecondsSinceEpoch <=
              int.parse(accelerates.docs
                      .where((element) => element.id == b.uid)
                      .firstOrNull
                      ?.data()['timeEnd'] ??
                  "0");

          if (valueA2 && valueB2) {
            return priorityA.compareTo(priorityB);
          } else if (valueB2) {
            return 1;
          } else {
            return -1;
          }
        },
      );
      List<String> idUserFollowers = [];
      List<UserEntity> userFollowers = await getUserFollowers();

      for (UserEntity user in userFollowers) {
        if ((await checkFollow(user.uid, helpersFunctions.idUser))) {
          idUserFollowers.add(user.uid ?? '');
        }
      }
      users.removeWhere((user) => idUserFollowers.contains(user.uid));

      return users;
    } on FirebaseException {
      return [];
    }
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> quicksort(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> list,
      int low,
      int high,
      LatLng center,
      QuerySnapshot<Map<String, dynamic>> locations) {
    if (low < high) {
      int partitionIndex = partition(list, low, high, center, locations);

      quicksort(list, low, partitionIndex - 1, center, locations);
      quicksort(list, partitionIndex + 1, high, center, locations);
    }
    return list;
  }

  int partition(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> list,
      int low,
      int high,
      LatLng centerLatLng,
      QuerySnapshot<Map<String, dynamic>> locations) {
    var pivot = list[high];
    int i = low - 1;

    for (int j = low; j < high; j++) {
      if (compareDocuments(list[j], pivot, centerLatLng, locations) <= 0) {
        i++;
        swap(list, i, j);
      }
    }

    swap(list, i + 1, high);
    return i + 1;
  }

  int compareDocuments(
      QueryDocumentSnapshot<Map<String, dynamic>> a,
      QueryDocumentSnapshot<Map<String, dynamic>> b,
      LatLng centerLatLng,
      QuerySnapshot<Map<String, dynamic>> locations) {
    GeoPoint geoPointA = locations.docs
        .firstWhere((element) => element.id == a.id)
        .data()['location'];
    GeoPoint geoPointB = locations.docs
        .firstWhere((element) => element.id == b.id)
        .data()['location'];

    num distanceA = Geodesy().distanceBetweenTwoGeoPoints(
        centerLatLng, LatLng(geoPointA.latitude, geoPointA.longitude));
    num distanceB = Geodesy().distanceBetweenTwoGeoPoints(
        centerLatLng, LatLng(geoPointB.latitude, geoPointB.longitude));

    final user01 = UserEntity.fromJson(a.data());
    final user02 = UserEntity.fromJson(a.data());

    if (compareUsers(user01) < compareUsers(user02)) {
      return 1;
    }

    return distanceA.compareTo(distanceB);
  }

  int compareUsers(UserEntity user) {
    int compare = 0;
    if (user.zodiac == helpersFunctions.zodiac) {
      compare++;
    }
    if (user.personalityType == helpersFunctions.personType) {
      compare++;
    }
    if (user.communicateStyle == helpersFunctions.communicationStyle) {
      compare++;
    }
    if (user.familyStyle == helpersFunctions.futureFamily) {
      compare++;
    }
    if (user.languageOfLove == helpersFunctions.loveLanguage) {
      compare++;
    }
    if (user.academicLever == helpersFunctions.education) {
      compare++;
    }
    if (user.drinkingStatus == helpersFunctions.alcoholConsumption) {
      compare++;
    }
    if (user.languageOfLove == helpersFunctions.loveLanguage) {
      compare++;
    }
    if (user.myPet == helpersFunctions.pets) {
      compare++;
    }

    return compare;
  }

  void swap(List<dynamic> list, int i, int j) {
    var temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }

  @override
  Future<List<UserEntity>>? getUsersTopRecentActive() async {
    List<UserEntity> usersTop = [];
    List<String> idUserToken = [];
    List<String> idUserFollowers = [];
    final dataToken = await database.collection(AppConfig.tableTokens).get();

    if (dataToken.docs.isNotEmpty) {
      List<Tokens> tokens =
          dataToken.docs.map((doc) => Tokens.fromJson(doc.data())).toList();
      tokens.sort((a, b) {
        int timeA = a.timeActive ?? 0;
        int timeB = b.timeActive ?? 0;

        int differenceA = (DateTime.now().millisecondsSinceEpoch - timeA).abs();
        int differenceB = (DateTime.now().millisecondsSinceEpoch - timeB).abs();

        return differenceA.compareTo(differenceB);
      });
      for (Tokens token in tokens) {
        idUserToken.add(token.idUser ?? '');
      }
    }
    List<UserEntity> userFollowers = await getUserFollowers();

    for (UserEntity user in userFollowers) {
      idUserFollowers.add(user.uid ?? '');
    }
    print("List follow: ${idUserFollowers.length ?? 0}");
    final data = await database
        .collection(AppConfig.tableUser)
        .where('uid', whereIn: idUserToken)
        .where('uid', isNotEqualTo: helpersFunctions.idUser)
        .get();

    usersTop = data.docs.map((e) => UserEntity.fromJson(e.data())).toList();
    usersTop.removeWhere((user) => idUserFollowers.contains(user.uid));

    print("List lọc: ${usersTop.length}");
    List<UserEntity> firstTenUsers =
        usersTop.length > 10 ? usersTop.sublist(0, 10) : usersTop;

    return firstTenUsers;
  }

  @override
  Future<List<UserEntity>>? getUsersTopCommonInterest() async {
    List<UserEntity> usersTop = [];
    List<String> idUserFollowers = [];
    UserEntity currentUser = await getUserProfile();

    List<UserEntity> userFollowers = await getUserFollowers();

    for (UserEntity user in userFollowers) {
      idUserFollowers.add(user.uid ?? '');
    }
    final data = await database
        .collection(AppConfig.tableUser)
        .where('uid', isNotEqualTo: helpersFunctions.idUser)
        .get();

    usersTop = data.docs.map((e) => UserEntity.fromJson(e.data())).toList();

    usersTop.removeWhere((user) => idUserFollowers.contains(user.uid));

//Lỗi
    List<UserEntity> filteredUsers = usersTop.where((user) {
      return user.interestsList
          .any((interest) => currentUser.interestsList.contains(interest));
    }).toList();
    print("filteredUsers: ${filteredUsers.length}");
    filteredUsers.sort((a, b) {
      int countA = a.interestsList
          .where((interest) => currentUser.interestsList.contains(interest))
          .length;
      int countB = b.interestsList
          .where((interest) => currentUser.interestsList.contains(interest))
          .length;

      return countB.compareTo(countA);
    });

    print("List trùng sở thích: ${filteredUsers.length}");

    List<UserEntity> firstTenUsers = filteredUsers.length > 10
        ? filteredUsers.sublist(0, 10)
        : filteredUsers;
    return firstTenUsers;
  }

  @override
  Future<UserEntity?> getOneUser({String? id}) async {
    try {
      final response = await database
          .collection(AppConfig.tableUser)
          .doc(id)
          .snapshots()
          .first;
      final user = UserEntity.fromJson(response.data() ?? {});
      return user;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<UserEntity> getUserProfile() async {
    return await database
        .collection(AppConfig.tableUser)
        .doc(helpersFunctions.idUser)
        .get()
        .then((doc) => UserEntity.fromJson(doc.data() ?? {}));
  }

  @override
  Future<void> updateUserProfile({
    required int gender,
    required int datingPurpose,
    required String? school,
    required String? introduceYourself,
    required List<String> photoList,
    required List<int> interestsList,
    required List<String>? fluentLanguageList,
    required String? company,
    required String? currentAddress,
    required int? height,

//BasicInfoUser
    required int? zodiac,
    required int? academicLever,
    required int? communicateStyle,
    required int? languageOfLove,
    required int? familyStyle,
    required String? personalityType,

//StyleOfLifeUser
    required int? myPet,
    required int? drinkingStatus,
    required int? smokingStatus,
    required int? sportsStatus,
    required int? eatingStatus,
    required int? socialNetworkStatus,
    required int? sleepingHabits,
    required SpotifyInformationEntity? spotifyInformation,
  }) async {
    String currentUid = helpersFunctions.idUser;
    return await database
        .collection(AppConfig.tableUser)
        .doc(currentUid)
        .update({
      'gender': gender,
      'datingPurpose': datingPurpose,
      'school': school,
      'introduceYourself': introduceYourself,
      'photoList': photoList,
      'interestsList': interestsList,
      'fluentLanguageList': fluentLanguageList,
      'company': company,
      'currentAddress': currentAddress,

      'height': height,
//BasicInfoUser
      'zodiac': zodiac,
      'academicLever': academicLever,
      'communicateStyle': communicateStyle,
      'languageOfLove': languageOfLove,
      'familyStyle': familyStyle,
      'personalityType': personalityType,

//StyleOfLifeUser
      'myPet': myPet,
      'drinkingStatus': drinkingStatus,
      'smokingStatus': smokingStatus,
      'sportsStatus': sportsStatus,
      'eatingStatus': eatingStatus,
      'socialNetworkStatus': socialNetworkStatus,
      'sleepingHabits': sleepingHabits,
    });
  }

  @override
  Future<bool?> followUser({String? uid}) async {
    try {
      bool checkFollow = false;

      await database.collection(AppConfig.tableUser).doc(uid).update({
        "followersList": FieldValue.arrayUnion([helpersFunctions.idUser])
      });
      await database
          .collection(AppConfig.tableUser)
          .doc(helpersFunctions.idUser)
          .get()
          .then((value) async {
        final List<dynamic>? list = await value.data()?['followersList'];
        if (list!.isNotEmpty) {
          for (var element in list ?? []) {
            if (element.toString() == uid) {
              checkFollow = true;
            }
          }
        }
      });
      return checkFollow;
    } on FirebaseException {
      return false;
    }
  }

  @override
  Future<String?> createChatsItem({String? uid}) async {
    try {
      bool check = true;
      final data = await database.collection(AppConfig.tableChatsItem).get();

      List<ChatItem>? list =
          data.docs.map((e) => ChatItem.fromJson(e.data())).toList();

      for (final element in list) {
        if ((element.uId01 == helpersFunctions.idUser &&
                element.uId02 == uid) ||
            (element.uId02 == helpersFunctions.idUser &&
                element.uId01 == uid)) {
          check = false;
        }
      }

      if (check) {
        final idChat = const Uuid().v1();
        await database.collection(AppConfig.tableChatsItem).doc(idChat).set(
            ChatItem(idChat, helpersFunctions.idUser, uid ?? "", '',
                    DateTime.now().toString())
                .toJson());
        return idChat;
      }
    } on FirebaseException catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<void> saveToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      final token = await messaging.getToken();
      final existToken = await database
          .collection(AppConfig.tableTokens)
          .doc(helpersFunctions.idUser)
          .get();
      if (existToken.exists) {
        await database
            .collection(AppConfig.tableTokens)
            .doc(helpersFunctions.idUser)
            .update({
          "idUser": helpersFunctions.idUser,
          "token": token,
          "time": (helpersFunctions.lastFetchedTimestamp as double).round(),
          "timeActive": timeService.timeNow.millisecondsSinceEpoch.toInt()
        });
      } else {
        await database
            .collection(AppConfig.tableTokens)
            .doc(helpersFunctions.idUser)
            .set(Tokens(
            idUser: helpersFunctions.idUser,
            token: token,
            time: (helpersFunctions.lastFetchedTimestamp as double).round(),
            timeActive:
            timeService.timeNow.millisecondsSinceEpoch.toInt())
            .toJson());
      }
    } on FirebaseException {}
  }

  @override
  Future<void> pushNotification(
      {String? uid, String? title, String? message, String? type}) async {
    try {
      final data =
          await database.collection(AppConfig.tableTokens).doc(uid).get();

      await dotenv.load(fileName: '.env');
      final user = Notification(
          data: Data(id: helpersFunctions.idUser, type: type),
          notification: ItemNotification(title ?? 'Finder', "$message"),
          token: data.data()?['token']);
      final String auth = dotenv.get('AUTH');

      dio.post(AppConfig.baseUrlFirebase,
          data: user.toJson(),
          options: Options(headers: {
            'Authorization': "key=$auth",
            "Content-Type": "application/json"
          }));
    } on DioException catch (e) {
      print(e);
    }
  }

  @override
  Future<void> saveNotification({Data? data, String? message}) async {
    try {
      ref
          .ref(AppConfig.tableNotification)
          .child(helpersFunctions.idUser)
          .child(const Uuid().v1())
          .set({
        'id': data?.id,
        'type': data?.type,
        'time': DateTime.now().millisecondsSinceEpoch.toString(),
        'message': message,
        'status': "false"
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Future<void> updateRequestToShow() async {
    try {
      await database
          .collection(AppConfig.tableUser)
          .doc(helpersFunctions.idUser)
          .update({'requestToShow': helpersFunctions.requestToShow});
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Future<List<UserEntity>> getUserFollowers() async {
    try {
      DocumentSnapshot currentUserDoc = await database
          .collection(AppConfig.tableUser)
          .doc(helpersFunctions.idUser)
          .get();

      final currentUser =
          UserEntity.fromJson(currentUserDoc.data() as Map<String, dynamic>);
      if (currentUser.followersList.isNotEmpty) {
        final data = await database
            .collection(AppConfig.tableUser)
            .where('uid', whereIn: currentUser.followersList)
            .get();
        List<UserEntity> listUser =
            data.docs.map((e) => UserEntity.fromJson(e.data())).toList();
        return listUser;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<bool> checkFollow(String uid, String followerId) async {
    try {
      bool checkMatch = false;
      DocumentSnapshot data1 =
          await database.collection(AppConfig.tableUser).doc(uid).get();
      DocumentSnapshot data2 =
          await database.collection(AppConfig.tableUser).doc(followerId).get();
      final user1 = UserEntity.fromJson(data1.data() as Map<String, dynamic>);

      final user2 = UserEntity.fromJson(data2.data() as Map<String, dynamic>);
      if (user1.followersList.contains(followerId) &&
          user2.followersList.contains(uid)) {
        checkMatch = true;
      }

      return checkMatch;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> removeFollow(String uid, String followerId) async {
    try {
      await database.collection(AppConfig.tableUser).doc(uid).update({
        'followersList': FieldValue.arrayRemove([followerId])
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<String?> startAccelerate() async {
    try {
      final data = await database
          .collection(AppConfig.tableAccelerate)
          .doc(helpersFunctions.idUser)
          .get();
      if (data.data() == null) {
        return '0';
      } else {
        final acc = Accelerate.fromJson(data.data() ?? {});
        if (acc.timeEnd == '0' ||
            int.parse(acc.timeEnd ?? "") <
                timeService.timeNow.millisecondsSinceEpoch) {
          if ((acc.turn ?? 0) <= 0) {
// hết lượt tăng tốc trong tháng
            return '3';
          } else {
            helpersFunctions.timeStart =
                timeService.timeNow.millisecondsSinceEpoch.toString();
            helpersFunctions.timeEnd = timeService.timeNow
                .add(const Duration(minutes: 30))
                .millisecondsSinceEpoch
                .toString();

            await database
                .collection(AppConfig.tableAccelerate)
                .doc(helpersFunctions.idUser)
                .update({
              'turn': (acc.turn ?? 1) - 1,
              "timeStart":
                  timeService.timeNow.millisecondsSinceEpoch.toString(),
              'timeEnd': timeService.timeNow
                  .add(const Duration(minutes: 30))
                  .millisecondsSinceEpoch
                  .toString()
            });
          }
// tăng tốc thành công
          return '1';
        } else {
// tăng tốc còn hiệu lực
          return '2';
        }
      }
    } on FirebaseException catch (e) {
      print(e);
      return '0';
    }
  }

  @override
  Future<void> createAccelerate(
      {required int turn, required int priority}) async {
    try {
      await database
          .collection(AppConfig.tableAccelerate)
          .doc(helpersFunctions.idUser)
          .set(Accelerate(
                  createAt:
                      timeService.timeNow.millisecondsSinceEpoch.toString(),
                  endAt: (timeService.timeNow
                          .add(const Duration(days: 30))
                          .millisecondsSinceEpoch)
                      .toString(),
                  priority: priority.toString(),
                  turn: turn,
                  uid: helpersFunctions.idUser,
                  timeEnd: '0',
                  timeStart: '0')
              .toJson());
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Future<void> createBill({required PayEntity payEntity}) async {
    try {
      print("object bill ${payEntity.toJson()}");
      await database
          .collection(AppConfig.tableUser)
          .doc(helpersFunctions.idUser)
          .collection('bills')
          .add(payEntity.toJson());
    } on FirebaseException {}
  }

  @override
  Future<int?> getTurnAccelerate() async {
    try {
      final data = await database
          .collection(AppConfig.tableAccelerate)
          .doc(helpersFunctions.idUser)
          .get();
      if (data.data() != null) {
        final accelerate = Accelerate.fromJson(data.data() ?? {});
        if ((int.parse(accelerate.endAt ?? "")) >=
            timeService.timeNow.millisecondsSinceEpoch) {
          return accelerate.turn ?? 0;
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    } on FirebaseException {
      return 0;
    }
  }

  @override
  Future<bool> getPrimaryAcceleration() async {
    try {
      final data = await database
          .collection(AppConfig.tableAccelerate)
          .doc(helpersFunctions.idUser)
          .get();
      if (data.data() != null) {
        final accelerate = Accelerate.fromJson(data.data() ?? {});
        if ((int.parse(accelerate.endAt ?? "")) >=
            timeService.timeNow.millisecondsSinceEpoch) {
          if(accelerate.turn == 0){
            return false;
          }

          return true;
        } else {

          return false;
        }
      } else {
        return false;
      }
    } on FirebaseException {
      return false;
    }
  }

  @override
  Future<bool> getPrimaryGold() async {
    try {
      final data = await database
          .collection(AppConfig.tableAccelerate)
          .doc(helpersFunctions.idUser)
          .get();
      if (data.data() != null) {
        final accelerate = Accelerate.fromJson(data.data() ?? {});
        if ((int.parse(accelerate.endAt ?? "")) >=
            timeService.timeNow.millisecondsSinceEpoch) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on FirebaseException {
      return false;
    }
  }

  @override
  Future<bool> createVideo({File? video}) async {
    try {
      final id = const Uuid().v4();
      final sto = FirebaseStorage.instance;
      Reference reference =
          sto.ref('video').child('${helpersFunctions.idUser}').child(id);

      if (video != null) {
        UploadTask uploadTask = reference.putFile(video);
        final tack = await uploadTask.whenComplete(() {});
        final url = await tack.ref.getDownloadURL();
        database
            .collection(AppConfig.tableStory)
            .doc(helpersFunctions.idUser)
            .collection('Video')
            .doc(id)
            .set(Story(
                    id: id,
                    createAt:
                        timeService.timeNow.millisecondsSinceEpoch.toString(),
                    url: url)
                .toJson());
        return true;
      } else {
        return false;
      }
    } on FirebaseException {
      return false;
    }
  }

  @override
  Future<List<StoryCard>?> getListVideo() async {
    List<StoryCard> list = [];
    try {
      final data = await getDataStory(id: helpersFunctions.idUser);
      final user = await database
          .collection(AppConfig.tableUser)
          .doc(helpersFunctions.idUser)
          .get();
      if (data != null) {
        list.add(StoryCard(
            listStory: data.map((e) => Story.fromJson(e.data())).toList(),
            avatar: user.data()?['avatar'],
            idUser: helpersFunctions.idUser,
            activeStatus: user.data()?['activeStatus'],
            name: user.data()?['fullName']));
      }

      await database
          .collection(AppConfig.tableChatsItem)
          .where('uId01', isEqualTo: helpersFunctions.idUser)
          .get()
          .then((value) async {
        for (var element in value.docs) {
          final user1 = await database
              .collection(AppConfig.tableUser)
              .doc(element.data()['uId02'])
              .get();
          final data1 = await getDataStory(id: element.data()['uId02']);

          if (data1 != null) {
            list.add(StoryCard(
                listStory: data1.map((e) => Story.fromJson(e.data())).toList(),
                avatar: user1.data()?['avatar'],
                activeStatus: user1.data()?['activeStatus'],
                idUser: user1.data()?['uid'],
                name: user1.data()?['fullName']));
          }
        }
      });
      await database
          .collection(AppConfig.tableChatsItem)
          .where('uId02', isEqualTo: helpersFunctions.idUser)
          .get()
          .then((value) async {
        for (var element in value.docs) {
          final user2 = await database
              .collection(AppConfig.tableUser)
              .doc(element.data()['uId01'])
              .get();
          final data2 = await getDataStory(id: element.data()['uId01']);
          if (data2 != null) {
            list.add(StoryCard(
                listStory: data2.map((e) => Story.fromJson(e.data())).toList(),
                avatar: user2.data()?['avatar'],
                activeStatus: user2.data()?['activeStatus'],
                idUser: user2.data()?['uid'],
                name: user2.data()?['fullName']));
          }
        }
      });
    } on FirebaseException {}
    return list;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> getDataStory(
      {String? id}) async {
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
      await database
          .collection(AppConfig.tableStory)
          .doc(id)
          .collection('Video')
          .orderBy('createAt', descending: true)
          .get()
          .then((value) {
        for (var element in value.docs) {
          if (DateTime.fromMillisecondsSinceEpoch(
                      int.parse(element.data()['createAt'].toString()))
                  .add(const Duration(days: 1))
                  .millisecondsSinceEpoch >=
              timeService.timeNow.millisecondsSinceEpoch) {
            data.add(element);
          } else {
// File('${helpersFunctions.pathDocument}/${element.data()['url'].hashCode}.jpg')
//   .delete();
          }
        }
      });
      return data;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<List<PayEntity>?> getAllBill() async {
    try {
      final response = await database
          .collection(AppConfig.tableUser)
          .doc(helpersFunctions.idUser)
          .collection('bills')
          .get();
      return response.docs.map((e) => PayEntity.fromJson(e.data())).toList();
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<Tokens?> getTokenById({required String id}) async {
    return await database
        .collection(AppConfig.tableTokens)
        .doc(id)
        .get()
        .then((doc) => Tokens.fromJson(doc.data() ?? {}));
  }

  @override
  Future<List<UserEntity>?> getTopUser() async {
    try {
      final accelerates = await database
          .collection(AppConfig.tableAccelerate)
          .where('uid', isNotEqualTo: helpersFunctions.idUser)
          .where('timeEnd',
              isLessThanOrEqualTo: timeService.timeNow.millisecondsSinceEpoch)
          .get();
      List<String>? list = accelerates.docs.map((e) => e.id).toList();
      database
          .collection(AppConfig.tableChatsItem)
          .where('uId01', isEqualTo: helpersFunctions.idUser)
          .get()
          .then((value) {
        for (var element in value.docs) {
          list.removeWhere((e) => e == element.data()['uId02']);
        }
      });
      database
          .collection(AppConfig.tableChatsItem)
          .where('uId02', isEqualTo: helpersFunctions.idUser)
          .get()
          .then((value) {
        for (var element in value.docs) {
          list.removeWhere((e) => e == element.data()['uId01']);
        }
      });

      final response = await database
          .collection(AppConfig.tableUser)
          .where('uid', whereIn: list)
          .get();
      return response.docs.map((e) => UserEntity.fromJson(e.data())).toList();
    } on FirebaseException {}
    return null;
  }

  @override
  Future<void> addSpotify(SpotifyInformationEntity? spotify) async {
    try {
      await database
          .collection(AppConfig.tableUser)
          .doc(helpersFunctions.idUser)
          .update({'spotify': spotify?.toJson()});
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Future<List<UserEntity>?> getUsersHaveSpotify(int requestToShow) async {
    try {
    final listUser =  await database
          .collection(AppConfig.tableUser)
          .where('spotify', isNull: false)
          .where('gender', isEqualTo: requestToShow)
          .get()
          .then((docs) =>
          docs.docs.map((e) => UserEntity.fromJson(e.data())).toList());

        List<UserEntity> filterUsers = listUser.where((user) => user.uid != helpersFunctions.idUser).toList();

      return filterUsers;

    } on FirebaseException catch (e) {
      print(e);

      return [];
    }
  }

  @override
  Future<bool> checkVerification() async {
    final Tokens userTokens = await FirebaseFirestore.instance
        .collection(AppConfig.tableTokens)
        .doc(helpersFunctions.idUser)
        .get()
        .then((value) => Tokens.fromJson(value.data() ?? {}));
    if (userTokens.isProfileVerified == null) return false;
    if (userTokens.isProfileVerified!) {
      return true;
    } else {
      return false;
    }
  }
  @override
  Future<bool> checkVerificationById({required String id}) async {
    final Tokens userTokens = await FirebaseFirestore.instance
        .collection(AppConfig.tableTokens)
        .doc(id)
        .get()
        .then((value) => Tokens.fromJson(value.data() ?? {}));
    if (userTokens.isProfileVerified == null) return false;
    if (userTokens.isProfileVerified!) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> reportUser({String? id, String? reasonTitle, String? reasonDetail, String? content}) async {
    try {
      await database.collection(AppConfig.tableReport).doc(id).set(Report(
              idUser: id,
              idUserReport: helpersFunctions.idUser,
              createAt: timeService.timeNow.millisecondsSinceEpoch,
              reasonTitle: reasonTitle,
              reasonDetail: reasonDetail,
              content: content
      )
          .toJson());

      return true;
    } on FirebaseException {
      return false;
    }
  }
}
