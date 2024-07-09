import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/chat_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

configureInjection() async {
  getIt.registerFactory<Dio>(() => Dio());
  getIt.registerFactory<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerFactory<FirebaseDatabase>(() => FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://finder-love-281af-default-rtdb.asia-southeast1.firebasedatabase.app'));

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      dio: getIt<Dio>(), database: getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(
      ref: getIt<FirebaseDatabase>(), database: getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      database: getIt<FirebaseFirestore>(),
      dio: getIt<Dio>(),
      ref: getIt<FirebaseDatabase>()));
}
