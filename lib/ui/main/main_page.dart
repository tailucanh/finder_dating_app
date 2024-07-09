import 'dart:async';
import 'package:chat_app/app.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/services/time_service.dart';
import 'package:chat_app/ui/chat_screen/chat_screen_page.dart';
import 'package:chat_app/ui/discover/discover_page.dart';
import 'package:chat_app/ui/home_screen/home_screen_page.dart';
import 'package:chat_app/ui/main/main_tab.dart';
import 'package:chat_app/ui/profile_screen/profile_screen_page.dart';
import 'package:chat_app/ui/top_and_like_user/main_top_and_like.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/popup_notification.dart';
import 'main_cubit.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainCubit();
      },
      child: const MainChildPage(),
    );
  }
}

class MainChildPage extends StatefulWidget {
  const MainChildPage({super.key});

  @override
  State<MainChildPage> createState() => _MainChildPageState();
}

class _MainChildPageState extends State<MainChildPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final MainCubit _cubit;
  late Timer timer;
  late AnimationController _controller;
  late Animation<double> _animation;

  late List<Widget> pageList;
  late PageController pageController;

  final tabs = [
    MainTab.home,
    MainTab.discover,
    MainTab.topAndLike,
    MainTab.chats,
    MainTab.profile,
  ];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.paused) {
      await getIt<AuthRepository>()
          .changedStatus(status: false)
          .then((value) async {
        await getIt<AuthRepository>().timeActive(
            time: (helpersFunctions.lastFetchedTimestamp as double).round());
        timer.cancel();
      });
    }
    if (state == AppLifecycleState.resumed) {
      await getIt<AuthRepository>().changedStatus(status: true).then((value) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          helpersFunctions.lastFetchedTimestamp =
              helpersFunctions.lastFetchedTimestamp + 1;
        });
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(minutes: timeService.timePlay),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: timeService.timeRunning,
      end: 0.0,
    ).animate(_controller);
    _controller.forward();

    WidgetsBinding.instance.addObserver(this);
    _cubit = BlocProvider.of(context);
    _cubit.startAccelerate(
        accelerate: (int.parse(helpersFunctions.timeEnd) >
            timeService.timeNow.millisecondsSinceEpoch));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      helpersFunctions.lastFetchedTimestamp =
          helpersFunctions.lastFetchedTimestamp + 1;
    });
    pageList = [
      const HomeScreenPage(),
      const DiscoverPage(),
      const MainTopAndLikePage(),
      const ChatScreenPage(),
      const ProfileScreenPage(),
    ];
    //Page controller
    pageController = PageController();
    getIt<AuthRepository>().changedStatus(status: true).then((value) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        helpersFunctions.lastFetchedTimestamp =
            helpersFunctions.lastFetchedTimestamp + 1;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pageController.page != 0) {
          _cubit.switchTap(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildBodyWidget(),
            BlocBuilder<MainCubit, MainState>(
              buildWhen: (previous, current) =>
                  previous.position != current.position,
              builder: (context, state) {
                return Positioned(
                  left: state.position?.dx ?? 10,
                  top: state.position?.dy ?? 100,
                  child: Draggable(
                    feedback: CircularProgressIndicator(
                      backgroundColor: Colors.grey.shade400,
                      color: Colors.grey.shade400,
                    ),
                    childWhenDragging: Container(),
                    child: BlocConsumer<MainCubit, MainState>(
                      listener: (context, state) {
                        if (state.accelerateStatus == LoadStatus.success) {
                          _controller.duration = const Duration(minutes: 30);
                          _animation = Tween<double>(
                            begin: 1,
                            end: 0.0,
                          ).animate(_controller);

                          _controller.reset();
                          _controller.forward(from: 0);
                        }
                      },
                      listenWhen: (previous, current) =>
                          previous.accelerateStatus != current.accelerateStatus,
                      buildWhen: (previous, current) =>
                          previous.accelerateStatus != current.accelerateStatus,
                      builder: (context, state) {
                        return  state.accelerateStatus == LoadStatus.success ? AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return CircularProgressIndicator(
                              value: _animation.value,
                              backgroundColor: Colors.transparent,
                              color: Colors.redAccent,
                            );
                          },
                        ) : const SizedBox();
                      },
                    ),
                    onDragEnd: (details) {
                      _cubit.changedPosition(details.offset);
                    },
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: BlocConsumer<MainCubit, MainState>(
          bloc: _cubit,
          listenWhen: (prev, current) {
            return prev.selectedIndex != current.selectedIndex ||
                prev.internetStatus != current.internetStatus;
          },
          listener: (context, state) {
            pageController.jumpToPage(state.selectedIndex);
            if (internetCheck == false) {
              AppPopupNotification.dialogCheckInternet(context: context);
            }
          },
          buildWhen: (prev, current) {
            return prev.selectedIndex != current.selectedIndex;
          },
          builder: (context, state) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
              elevation: 8,
              selectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
              currentIndex: state.selectedIndex,
              items:
                  tabs.map((e) => e.tab(index: state.selectedIndex)).toList(),
              onTap: (index) {
                _cubit.switchTap(index);
                pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return PageView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: pageList,
      onPageChanged: (index) {
        _cubit.switchTap(index);
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    timer.cancel();
    pageController.dispose();
    super.dispose();
  }
}
