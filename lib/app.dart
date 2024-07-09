import 'package:chat_app/app/app_theme.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/router/router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'app/app_setting/app_setting_cubit.dart';
import 'generated/l10n.dart';
import 'package:chat_app/services/notification_controller.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? initialMessage;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) async {
      if (event != ConnectivityResult.none) {
        internetCheck =
            (await InternetConnectionChecker().hasConnection) || kDebugMode;
      } else {
        internetCheck = false;
      }
    });
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (mounted) {}
    });

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AppRoutes.navigationKey.currentState
          ?.pushReplacementNamed(AppRoutes.setting);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Connectivity().onConnectivityChanged.listen((event) async {
      if (event != ConnectivityResult.none) {
        internetCheck =
            (await InternetConnectionChecker().hasConnection) || kDebugMode;
      } else {
        internetCheck = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HelpersFunctions.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            helpersFunctions = snapshot.data;
            return BlocProvider(
              create: (context) {
                return AppSettingCubit();
              },
              child: GestureDetector(
                onTap: () => _hideKeyboard(context),
                child: BlocBuilder<AppSettingCubit, AppSettingState>(
                  builder: (context, state) {
                    ScreenUtil.init(context);
                    return MaterialApp.router(
                      title: 'Finder - Match And Chat',
                      debugShowCheckedModeBanner: false,
                      theme: AppTheme.light,
                      darkTheme: AppTheme.dark,
                      themeMode: state.themeMode,
                      locale: state.locale,
                      supportedLocales: S.delegate.supportedLocales,
                      localizationsDelegates: const [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        S.delegate,
                      ],
                      // Add this line,
                      routerConfig: AppRoutes.router,
                    );
                  },
                ),
              ),
            );
          }
          return Container();
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

void _hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

var internetCheck = true;
