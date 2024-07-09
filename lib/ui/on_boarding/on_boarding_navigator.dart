import 'package:chat_app/router/router.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_navigator.dart';

class OnBoardingNavigator extends AppNavigator {
  OnBoardingNavigator({required super.context});

  void openPage() {
    context.goNamed(AppRoutes.login);
    // context.go('/home/setting');
  }
}
