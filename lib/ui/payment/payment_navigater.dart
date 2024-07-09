
import 'package:chat_app/app/app_navigator.dart';
import 'package:go_router/go_router.dart';

class PaymentNavigator extends AppNavigator {
  PaymentNavigator({required super.context});

  backHome() {
    context.pop();
  }
}
