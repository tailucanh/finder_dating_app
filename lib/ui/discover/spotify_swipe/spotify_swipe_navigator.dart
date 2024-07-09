import 'package:chat_app/app/app_navigator.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/router/router.dart';
import 'package:go_router/go_router.dart';

class SpotifySwipeNavigator extends AppNavigator {
  SpotifySwipeNavigator({required super.context});

  void openPayment() {
    context.goNamed(AppRoutes.payment);
  }

  void goToDetailProfile(UserEntity userEntity) {
    context.goNamed(AppRoutes.detailProfile, extra: userEntity);
  }
}
