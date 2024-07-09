import 'package:chat_app/app/app_navigator.dart';
import 'package:chat_app/router/router.dart';
import 'package:go_router/go_router.dart';

class ProfileScreenNavigator extends AppNavigator {
  ProfileScreenNavigator({required super.context});

  void openPage() {
    //Todo
  }

  void goToSetting() {
    context.goNamed(AppRoutes.setting);
  }
}
