import 'package:chat_app/app/app_navigator.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:go_router/go_router.dart';
import '../../router/router.dart';

class HomeScreenNavigator extends AppNavigator {
  HomeScreenNavigator({required super.context});

  Future<void> openPayment() async {
    await context.pushNamed(AppRoutes.payment);
  }

  void goToDetailProfile(UserEntity userEntity) {
    context.goNamed(AppRoutes.detailProfile, extra: userEntity);
  }
}
