import 'package:chat_app/app/app_navigator.dart';
import 'package:chat_app/router/router.dart';
import 'package:go_router/go_router.dart';

class ChatScreenNavigator extends AppNavigator {
  ChatScreenNavigator({required super.context});

  void openPage(String? path) {
    GoRouter.of(context)
        .goNamed(AppRoutes.createStory, queryParameters: {'path': path});
  }
}
