import 'package:chat_app/app/app_navigator.dart';
import 'package:chat_app/router/router.dart';
import 'package:go_router/go_router.dart';

class CreateAccNavigator extends AppNavigator {
  CreateAccNavigator({required super.context});

  void openPage() {
    context.pushReplacementNamed(AppRoutes.main);
  }
}
