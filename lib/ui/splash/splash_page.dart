import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_cubit.dart';
import 'splash_navigator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashCubit(
          navigator: SplashNavigator(context: context),
        );
      },
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({super.key});

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late final SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.transparent,
        child: Text('Copy right ©2023 - ${_cubit.currentYear} . All rights reserved.',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow:  TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        child: Center(
          child: SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('ic_tinder_logo'.withImage())),
        ),
      )
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
