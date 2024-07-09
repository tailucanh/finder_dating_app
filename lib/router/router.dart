import 'package:chat_app/model/entities/pay_entity.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/router/transition_slide.dart';
import 'package:chat_app/ui/chat_screen/widgets/create_story/create_story_page.dart';
import 'package:chat_app/ui/chat_search/chat_search_page.dart';
import 'package:chat_app/ui/detail_profile/report_user/report_user_page.dart';
import 'package:chat_app/ui/discover/spotify_swipe/spotify_swipe_page.dart';
import 'package:chat_app/ui/discover/verify_avatar/verify_avatar_page.dart';
import 'package:chat_app/ui/login/auth/phone/login_phone_page.dart';
import 'package:chat_app/ui/login/create_acc/create_acc_page.dart';
import 'package:chat_app/ui/login/login_page.dart';
import 'package:chat_app/ui/main/main_page.dart';
import 'package:chat_app/ui/notification/notification_page.dart';
import 'package:chat_app/ui/on_boarding/on_boarding_page.dart';
import 'package:chat_app/ui/payment/pay_methods/payment_methods_page.dart';
import 'package:chat_app/ui/payment/payment_cubit.dart';
import 'package:chat_app/ui/payment/payment_page.dart';
import 'package:chat_app/ui/setting/bills_management/bills_management.dart';
import 'package:chat_app/ui/setting/payment_account/payment_account_page.dart';
import 'package:chat_app/ui/setting/setting_page.dart';
import 'package:chat_app/ui/setting_query/setting_query_page.dart';
import 'package:chat_app/ui/splash/splash_page.dart';
import 'package:chat_app/ui/update_profile/choose_spotify_song/choose_spotify_song.dart';
import 'package:chat_app/ui/update_profile/update_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/chat_detail/chat_detail_page.dart';
import '../ui/detail_profile/detail_profile_user_page.dart';
import '../ui/login/auth/verify_otp/verify_otp_page.dart';

class AppRoutes {
  AppRoutes._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    routes: _routes,
    debugLogDiagnostics: true,
    navigatorKey: navigationKey,
  );

  // Name routes
  static const home = "home";
  static const whoLike = "whoLike";
  static const createStory = "createStory";
  static const chat = "chat";
  static const profile = "profile";
  static const top = "top";
  static const main = "main";
  static const welcome = "/";
  static const onBoarding = "onBoarding";
  static const login = "login";
  static const loginPhone = "loginPhone";
  static const confirmProfile = "confirmProfile";
  static const verifyOtp = "verifyOtp";
  static const setting = "setting";
  static const showMe = "showMe";
  static const updateProfile = "updateProfile";
  static const detailChat = "detailChat";
  static const searchChat = "searchChat";
  static const payment = "payment";
  static const paymentMethods = "paymentMethods";
  static const settingQuery = "settingQuery";
  static const notification = "notification";
  static const detailProfile = "detailProfile";
  static const reportUser = "reportUser";
  static const spotifySwipe = "spotifySwipe";
  static const verifyAvatar = "verifyAvatar";
  static const chooseSpotifySong = "chooseSpotifySong";
  static const billManagement = "billManagement";
  static const paymentAccountPage = "paymentAccountPage";


//ddd
  static final _routes = <RouteBase>[
    GoRoute(
      path: welcome,
      name: welcome,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: const SplashPage(),
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/$onBoarding',
      name: onBoarding,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BuildCustomTransitionPage(
            key: state.pageKey, child: const OnBoardingPage());
      },
    ),
    GoRoute(
      path: '/$login',
      name: login,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BuildCustomTransitionPage(
            key: state.pageKey, child: const LoginPage());
      },
    ),
    GoRoute(
        path: '/$confirmProfile',
        name: confirmProfile,
        pageBuilder: TransitionFactory.getSlidePageBuilder(
            child: const CreateAccPage(), leftToRight: true)),
    GoRoute(
      path: '/$loginPhone',
      name: loginPhone,
      routes: [
        GoRoute(
            path: verifyOtp,
            name: verifyOtp,
            pageBuilder: TransitionFactory.getSlidePageBuilder(
                child: const VerifyOtpPage(), leftToRight: true)),
      ],
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BuildCustomTransitionPage(
            key: state.pageKey, child: const LoginPhonePage());
      },
    ),
    GoRoute(
        path: '/$main',
        name: main,
        pageBuilder: TransitionFactory.getSlidePageBuilder(
            child: const MainPage(), leftToRight: true),
        routes: [
          GoRoute(
              path: detailProfile,
              name: detailProfile,
              routes: [
                GoRoute(
                    path: reportUser,
                    name: reportUser,
                    pageBuilder: (BuildContext context, GoRouterState state) {
                    String idUser = state.extra as String;
                    return BuildCustomTransitionPage(
                        key: state.pageKey, child: ReportUserPage(idUser: idUser));
                  },
                ),
              ],
              pageBuilder: (BuildContext context, GoRouterState state) {
                UserEntity user = state.extra as UserEntity;
                return BuildCustomTransitionPage(
                    key: state.pageKey, child: DetailProfileUser(user: user));
              },
            ),
          GoRoute(
              path: payment,
              name: payment,
              routes: [
                GoRoute(
                  path: paymentMethods,
                  name: paymentMethods,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    PaymentCubit paymentCubit = state.extra as PaymentCubit;
                    return BuildCustomTransitionPage(
                        key: state.pageKey, child: PaymentMethodsPage(cubit: paymentCubit));
                  },
                ),
              ],
              pageBuilder: TransitionFactory.getSlidePageBuilder(
                  child: const PaymentPage())),
          GoRoute(
              path: createStory,
              name: createStory,
              pageBuilder: TransitionFactory.getSlidePageBuilder(
                  child: const CreateStoryPage())
          ),
          GoRoute(
              path: updateProfile,
              name: updateProfile,
              builder: (context, state) {
                UserEntity user = state.extra as UserEntity;
                return UpdateProfilePage(user: user);
              }),
          GoRoute(
              path: detailChat,
              name: detailChat,
              pageBuilder: TransitionFactory.getSlidePageBuilder(
                  child: const ChatDetailPage())),
          GoRoute(
              path: searchChat,
              name: searchChat,
              pageBuilder: TransitionFactory.getSlidePageBuilder(
                  child: const ChatSearchPage())),
          GoRoute(
            path: setting,
            name: setting,
            routes: [
              GoRoute(
                  path: billManagement,
                  name: billManagement,
                  pageBuilder: TransitionFactory.getSlidePageBuilder(
                      child: const BillsManagement())),
              GoRoute(
                  path: paymentAccountPage,
                  name: paymentAccountPage,
                  pageBuilder: TransitionFactory.getSlidePageBuilder(
                      child: const PaymentAccountPage())),
            ],
            pageBuilder: TransitionFactory.getSlidePageBuilder(
              child: const SettingPage(),
            ),
          ),
          GoRoute(
              path: settingQuery,
              name: settingQuery,
              pageBuilder: TransitionFactory.getSlidePageBuilder(
                  child: const SettingQueryPage())),
          GoRoute(
              path: notification,
              name: notification,
              pageBuilder: TransitionFactory.getSlidePageBuilder(
                  child: const NotificationPage())),
          GoRoute(
              path: spotifySwipe,
              name: spotifySwipe,
              pageBuilder: TransitionFactory.getSlidePageBuilder(
                  child: const SpotifySwipePage())),

          GoRoute(
              path: verifyAvatar,
              name: verifyAvatar,
              pageBuilder: TransitionFactory.getSlidePageBuilder(
                  child: const VerifyAvatarPage())),

          GoRoute(
              path: chooseSpotifySong,
              name: chooseSpotifySong,
              pageBuilder: TransitionFactory.getSlidePageBuilder(
                  child: const ChooseSpotifySong())),
        ]),
  ];

  static CustomTransitionPage<void> BuildCustomTransitionPage({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      barrierDismissible: true,
      barrierColor: Colors.black38,
      opaque: false,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
