import 'dart:async';
import 'dart:developer';

import 'package:chat_app/app/app_config.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/entities/chat_item.dart';
import 'package:chat_app/model/entities/message.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/params/card_chat.dart';
import 'package:chat_app/model/params/notification_item.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class ChatRepository {
  Stream<List<CardChat>?>? getAllChats();

  Future<List<NotificationItem>?> getListNotification();

  Future<void> updateStatusNotification(
      {required String id, required String time, required String status});

  Stream<List<Message>>? getChatByIdChat({String? idChat});

  Future<List<Message>?> loadMoreMessages({String? idChat, int? currentIndex});

  Future<void> addChat({String? title, Message? message, String? idChat});

  Future<ChatItem?> getChatByUid({
    required String opponentUid,
  });

  Future<List<CardChat>> searchChatByUsername(String username);
}

class ChatRepositoryImpl extends ChatRepository {
  FirebaseFirestore database;
  FirebaseDatabase ref;

  ChatRepositoryImpl({required this.database, required this.ref});

  @override
  Future<void> addChat(
      {String? title, Message? message, String? idChat}) async {
    try {
      await database
          .collection(AppConfig.tableChatsItem)
          .doc(idChat)
          .collection(AppConfig.tableChats)
          .doc(message?.idItemChat)
          .set(message?.toJson() ?? {});
      await getIt<UserRepository>().pushNotification(
          uid: message?.idUser,
          title: title,
          message: message?.message,
          type: 'chat');
      await database
          .collection(AppConfig.tableChatsItem)
          .doc(idChat)
          .update({'lastMessage': message?.message});
    } on FirebaseException catch (e) {
      log("FirebaseException", error: e);
    }
  }

  @override
  Stream<List<CardChat>?>? getAllChats() {
    try {
      final StreamController<List<CardChat>?> streamController =
          StreamController<List<CardChat>?>();
      List<CardChat> listChat = [];
      void addDataToList(QuerySnapshot query) {
        for (var element in query.docs) {
          String otherUserId;
          String currentUserId = helpersFunctions.idUser;
          final map = element.data() as Map<String, dynamic>;
          if (map['uId01'] == currentUserId) {
            otherUserId = map['uId02'];
          } else {
            otherUserId = map['uId01'];
          }

          if (listChat.any((cardChat) => cardChat.idChat == element.id)) {
            listChat[listChat.indexWhere(
                (cardChat) => cardChat.idChat == element.id)] = CardChat(
              idChat: element.id,
              idUser: otherUserId,
              lastMessage: map['lastMessage'],
            );
          } else {
            listChat.add(CardChat(
              idChat: element.id,
              idUser: otherUserId,
              lastMessage: map['lastMessage'],
            ));
          }
        }

        streamController.add(listChat);
      }

      database
          .collection(AppConfig.tableChatsItem)
          .where('uId01', isEqualTo: helpersFunctions.idUser)
          .snapshots()
          .listen(addDataToList);

      database
          .collection(AppConfig.tableChatsItem)
          .where('uId02', isEqualTo: helpersFunctions.idUser)
          .snapshots()
          .listen(addDataToList);
      return streamController.stream;
    } catch (e) {
      print(e);
      return Stream.error(e);
    }
  }

  @override
  Stream<List<Message>>? getChatByIdChat({String? idChat}) {
    try {
      return database
          .collection(AppConfig.tableChatsItem)
          .doc(idChat)
          .collection(AppConfig.tableChats)
          .orderBy('createAt', descending: true)
          .limit(20)
          .snapshots()
          .asyncMap((event) {
        // Assuming Message is the class for your chat messages
        List<Message> messages = [];

        for (var doc in event.docs) {
          // Assuming you have a fromMap method in your Message class
          var message = Message.fromJson(doc.data());
          messages.add(message);
        }

        return messages;
      });
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<List<Message>?> loadMoreMessages(
      {String? idChat, int? currentIndex}) async {
    try {
      final loadedData = await database
          .collection(AppConfig.tableChatsItem)
          .doc(idChat)
          .collection(AppConfig.tableChats)
          .orderBy('createAt', descending: true)
          .limit(currentIndex!)
          .get();
      final lastVisible = loadedData.docs[loadedData.size - 1];

      return await database
          .collection(AppConfig.tableChatsItem)
          .doc(idChat)
          .collection(AppConfig.tableChats)
          .orderBy('createAt', descending: true)
          .startAtDocument(lastVisible)
          .limit(20)
          .get()
          .then((docs) {
        return docs.docs.map((e) => Message.fromJson(e.data())).toList();
      });
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<List<NotificationItem>?> getListNotification() async {
    try {
      List<NotificationItem> list = [];
      final data = await ref
          .ref(AppConfig.tableNotification)
          .child(helpersFunctions.idUser)
          .once();

      for (var element in data.snapshot.children) {
        list.add(NotificationItem.fromSnapshot(element));
      }

      //for (var element in data) {
      //    list.add(NotificationItem.fromSnapshot(element));
      //  }

      return list;
    } on FirebaseException catch (e) {
      log("Err", error: e);
      return null;
    }
  }

  @override
  Future<void> updateStatusNotification(
      {required String id,
      required String time,
      required String status}) async {
    try {
      ref
          .ref(AppConfig.tableNotification)
          .child(helpersFunctions.idUser)
          .onValue
          .listen((event) async {
        for (var element in event.snapshot.children) {
          NotificationItem notificationItem =
              NotificationItem.fromSnapshot(element);
          if (notificationItem.id == id && notificationItem.time == time) {
            await ref
                .ref(AppConfig.tableNotification)
                .child(helpersFunctions.idUser)
                .child(element.key.toString())
                .update({'status': status});
          }
        }
      });
    } on FirebaseException catch (e) {
      log("Err", error: e);
    }
  }

  @override
  Future<ChatItem?> getChatByUid({required String opponentUid}) async {
    debugPrint(helpersFunctions.idUser);
    try {
      List<ChatItem> listChat = [];
      final query1 = await database
          .collection(AppConfig.tableChatsItem)
          .where('uId01', isEqualTo: helpersFunctions.idUser)
          .get();
      final query2 = await database
          .collection(AppConfig.tableChatsItem)
          .where('uId02', isEqualTo: helpersFunctions.idUser)
          .get();
      if (query1.docs.isNotEmpty) {
        for (var element in query1.docs) {
          listChat.add(ChatItem.fromJson(element.data()));
        }
      }
      if (query2.docs.isNotEmpty) {
        for (var element in query2.docs) {
          listChat.add(ChatItem.fromJson(element.data()));
        }
      }
      if (listChat.any((chat) => chat.uId01 == opponentUid)) {
        return listChat.singleWhere((chat) => chat.uId01 == opponentUid);
      } else if (listChat.any((chat) => chat.uId02 == opponentUid)) {
        return listChat.singleWhere((chat) => chat.uId02 == opponentUid);
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  @override
  Future<List<CardChat>> searchChatByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection(AppConfig.tableUser)
        .where('fullName',
            isGreaterThanOrEqualTo: username,
            isLessThan: username.substring(0, username.length - 1) +
                String.fromCharCode(
                    username.codeUnitAt(username.length - 1) + 1))
        .get()
        .then((data) async {
      List<UserEntity> users =
          data.docs.map((doc) => UserEntity.fromJson(doc.data())).toList();

      List<Future<UserEntity?>> matchedUserFuture = users.map((user) async {
        bool isFollowingCurrentUser = await GetIt.instance<UserRepository>()
            .checkFollow(user.uid, helpersFunctions.idUser);

        bool isCurrentUserFollowing = await GetIt.instance<UserRepository>()
            .checkFollow(helpersFunctions.idUser, user.uid);

        if (isFollowingCurrentUser && isCurrentUserFollowing) {
          return user;
        }
      }).toList();

      var matchedUser = await Future.wait(matchedUserFuture);
      matchedUser = matchedUser.where((e) => e != null).toList();

      List<Future<CardChat>> cardChatsFuture = matchedUser.map((user) async {
        ChatItem? chat = await getChatByUid(opponentUid: user!.uid);

        return CardChat(
            idChat: chat!.id, idUser: user.uid, lastMessage: chat.lastMessage);
      }).toList();
      return await Future.wait(cardChatsFuture);
    });
  }
}
