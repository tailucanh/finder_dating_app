import 'package:chat_app/app/app_navigator.dart';
import 'package:chat_app/router/router.dart';
import 'package:go_router/go_router.dart';

class LoginPhoneNavigator extends AppNavigator {
  LoginPhoneNavigator({required super.context});

  openSmsOtp({String? id}) {
    context.go(AppRoutes.verifyOtp);
  }

  openCreateAcc() {
    context.goNamed(AppRoutes.showMe);
  }
}
