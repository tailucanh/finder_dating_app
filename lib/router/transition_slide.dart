import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransitionFactory {

  static CustomTransitionPage getSlideTransitionPage(
      {required BuildContext context,
      required GoRouterState state,
      required Widget child,
      required bool leftToRight}) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      arguments: state.pathParameters,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(0.5, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.fastLinearToSlowEaseIn)),
              ),
// textDirection:
//    leftToRight ? TextDirection.ltr : TextDirection.rtl,
              child: child),
    );
  }

  static Page<dynamic> Function(BuildContext context, GoRouterState state)
      getSlidePageBuilder({required Widget child, bool? leftToRight = false}) {
    return (context, state) => TransitionFactory.getSlideTransitionPage(
          context: context,
          state: state,
          child: child,
          leftToRight: leftToRight!, /*leftToRight: leftToRight*/
        );
  }

}
