import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/top_user_cubit.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/top_user_navigator.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/top_user_page.dart';
import 'package:chat_app/ui/top_and_like_user/who_love/who_love_cubit.dart';
import 'package:chat_app/ui/top_and_like_user/who_love/who_love_navigator.dart';
import 'package:chat_app/ui/top_and_like_user/who_love/who_love_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';

class MainTopAndLikePage extends StatelessWidget {
  const MainTopAndLikePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context){
          return WhoLoveCubit(navigator: WhoLoveNavigator(context: context));
        }),
        BlocProvider(create: (context){
          return TopUserCubit(navigator: TopUserNavigator(context: context));
        })
      ],
      child: const MainTopAndLikeChildPage(),
    );
  }
}

class MainTopAndLikeChildPage extends StatefulWidget {
  const MainTopAndLikeChildPage({
    super.key,
  });

  @override
  State<MainTopAndLikeChildPage> createState() => _MainTopAndLikePageState();
}

class _MainTopAndLikePageState extends State<MainTopAndLikeChildPage> {
  bool _isTabSelected = true;
  late final WhoLoveCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'ic_tinder_logo'.withImage(),
                    width: 30.w,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(colors: [
                            Color(0xFFd73730),
                            Color(0xFFee0979),
                          ]).createShader(bounds),
                      child: Text(
                        'Finder',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.sp,
                            fontFamily: "Kanit",
                            fontWeight: FontWeight.w800),
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<WhoLoveCubit, WhoLoveState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _isTabSelected = true;
                          });
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 5,
                          child: Text(
                            '${(state.userFollowers ?? []).isNotEmpty ? state.userFollowers?.length : ''} ${S().titleLike}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 3,
                              color: _isTabSelected
                                  ? Colors.red
                                  : Colors.grey.shade500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    height: 25,
                    width: 1.5,
                    color: Colors.grey.shade300,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isTabSelected = false;
                      });
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 5,
                      child: Text(
                        S().titleTopUser,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 3,
                            color: !_isTabSelected
                                ? Colors.red
                                : Colors.grey.shade500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: _isTabSelected ? const WhoLovePage() : const TopUserPage(),
    );
  }
}
