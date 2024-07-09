import 'package:chat_app/router/router.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_navigator.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator({required super.context});

  void openLogin() {
    context.pushReplacementNamed(AppRoutes.onBoarding);
  }

  void openHome() {
    context.pushReplacementNamed(AppRoutes.main);
  }
}
