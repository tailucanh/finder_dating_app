import 'package:chat_app/app/app_navigator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../router/router.dart';

class LoginNavigator extends AppNavigator {
  LoginNavigator({required super.context});

  void openPageLoginGoogle(
      {GoogleSignInAccount? account, String? accessToken, String? idToken}) {
    if (account != null) {
      context.goNamed(AppRoutes.confirmProfile, queryParameters: {
        'email': account.email,
        'fullName': account.displayName,
        'accessToken': accessToken,
        'idToken': idToken,
      });
    }
  }

  void openPageHome() {
    context.goNamed(AppRoutes.main);
  }

  void openCreateAccPage() {
    context.goNamed(AppRoutes.confirmProfile);
  }
}
