import 'package:chat_app/app/app_navigator.dart';
import 'package:chat_app/router/router.dart';
import 'package:go_router/go_router.dart';

class ChatSearchNavigator extends AppNavigator {
  ChatSearchNavigator({required super.context});

  void openPage(String? path) {
    context.goNamed(AppRoutes.createStory, queryParameters: {'path': path});
  }
}
