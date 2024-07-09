import 'dart:math';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../app.dart';
import '../../generated/l10n.dart';
import '../../model/enums/load_state.dart';
import '../widgets/popup_notification.dart';
import 'login_cubit.dart';
import 'login_navigator.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginCubit(
          navigator: LoginNavigator(context: context),
        );
      },
      child: const LoginChildPage(),
    );
  }
}

class LoginChildPage extends StatefulWidget {
  const LoginChildPage({super.key});

  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {
  late final LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppPopupNotification.dialogExitApp(
            context: context,
            content: S.current.contentDialogExitRegister,
            onExit: () => SystemNavigator.pop());
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: _buildBodyWidget(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: _cubit,
      buildWhen: (previous, current) =>
          previous.loadDataStatus != current.loadDataStatus,
      builder: (context, state) {
        return state.loadDataStatus == LoadStatus.initial
            ? Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  color: const Color(0xFFd73730),
                  size: 70,
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                   begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(238, 128, 95, 1),
                    Color.fromRGBO(236, 149, 123, 1),
                    Color.fromRGBO(234, 64, 128, 1),
                    Color.fromRGBO(232, 98, 148, 1),
                  ],
                  transform: GradientRotation(pi / 4),
                )
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'ic_tinder_logo'.withImage(),
                            width: 80,
                          ),
                          ShaderMask(
                              shaderCallback: (bounds) =>
                                  const LinearGradient(colors: [
                                    Color(0xFFd73730),
                                    Color(0xFFee0979),
                                  ]).createShader(bounds),
                              child: const Text(
                                'Finder',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Kanit",
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              )),
                        ]),
                    Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: S.current.contentLogin1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: S.current.contentLogin2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                    fontSize: 16),
                              ),
                              TextSpan(text: S.current.contentLogin3),
                              TextSpan(
                                text: S.current.contentLogin4,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                    fontSize: 16),
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onTap: () {
                            if (!internetCheck) {
                              AppPopupNotification.dialogCheckInternet(
                                  context: context);
                            } else {
                              _cubit.loginWithGoogle();
                            }
                          },
                          title: S.current.titleGoogleSignInButton,
                          icon: 'google'.withIconPNG(),
                          isBorder: true,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomButton(
                          onTap: () {
                            context.goNamed(AppRoutes.loginPhone);
                          },
                          title: S.current.titlePhoneNumberSignInButton,
                          icon: 'phone'.withIconPNG(),
                          isBorder: true,
                        ),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
