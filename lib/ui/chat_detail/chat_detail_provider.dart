import 'dart:io';
import 'package:chat_app/app/app_config.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/entities/message.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/params/tokens.dart';
import 'package:chat_app/repositories/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../../di/network_repository.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ChatProvider extends ChangeNotifier {
  Stream<List<Message>>? _list;
  final String? idChat;
  final String? idUser;
  UserEntity? _targetUser;
  UserEntity? _currentUser;
  Tokens? _tokensTime;
  bool isSending = false;

  ChatProvider({required this.idChat, required this.idUser});

  Stream<List<Message>>? get listMessage => _list;

  UserEntity? get targetUser => _targetUser;

  UserEntity? get currentUser => _currentUser;

  Tokens? get tokensTimme => _tokensTime;

  void setIsSending(bool loading) {
    isSending = loading;
    notifyListeners();
  }

  Future<void> fetchData() async {
    _list = GetIt.instance<ChatRepository>().getChatByIdChat(idChat: idChat);
    var dataUserTarget = await getIt<FirebaseFirestore>()
        .collection(AppConfig.tableUser)
        .doc(idUser)
        .snapshots()
        .first;

    _targetUser = UserEntity.fromJson(dataUserTarget.data() ?? {});
    var dataUserCurrent = await getIt<FirebaseFirestore>()
        .collection(AppConfig.tableUser)
        .doc(helpersFunctions.idUser)
        .snapshots()
        .first;
    _currentUser = UserEntity.fromJson(dataUserCurrent.data() ?? {});

    var timeUser = await getIt<FirebaseFirestore>()
        .collection(AppConfig.tableTokens)
        .doc(targetUser?.uid)
        .snapshots()
        .first;
    _tokensTime = Tokens.fromJson(timeUser.data() ?? {});

    // if ((_list ?? []).isNotEmpty &&
    //     _targetUser != null &&
    //     _currentUser != null) {
    //   notifyListeners();
    // }
  }

  Future<void> chatMessage({String? title, Message? message}) async {
    await getIt<ChatRepository>()
        .addChat(title: title, message: message, idChat: idChat);
    notifyListeners();
  }

  Future<File> compressFile(File file) async {
    final filePath = file.absolute.path;
    debugPrint(filePath);
    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jpg'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 40,
    );
    final compressedFile = File(result!.path);
    print(file.lengthSync());
    print(compressedFile.lengthSync());

    return compressedFile;
  }

  Future<String> uploadFile(File imageFile, String idChat) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageId = const Uuid().v4();
    final compressedImage = await compressFile(imageFile);
    await storageRef.child('chat_images/$idChat/$imageId').putFile(compressedImage);
    return await storageRef
        .child('chat_images/$idChat/$imageId')
        .getDownloadURL();
  }

  Future<String> uploadAudioFile(File audioFile) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageId = const Uuid().v4();
    await storageRef.child('chat_audio/$idChat/$imageId').putFile(audioFile);
    return await storageRef
        .child('chat_audio/$idChat/$imageId')
        .getDownloadURL();
  }
}
