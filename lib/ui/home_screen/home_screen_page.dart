import 'dart:math';

import 'package:chat_app/app.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/services/time_service.dart';
import 'package:chat_app/ui/home_screen/widgets/bottom_accelerates.dart';
import 'package:chat_app/ui/home_screen/widgets/card_detail.dart';
import 'package:chat_app/ui/main/main_cubit.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../config/firebase/firebase_api.dart';
import '../../generated/l10n.dart';
import '../login/widgets/button_submit_page_view.dart';
import '../widgets/popup_notification.dart';
import 'home_screen_cubit.dart';
import 'home_screen_navigator.dart';
import 'widgets/item_controller.dart';

class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeScreenCubit(
          navigator: HomeScreenNavigator(context: context),
        );
      },
      child: const HomeScreenChildPage(),
    );
  }
}

class HomeScreenChildPage extends StatefulWidget {
  const HomeScreenChildPage({super.key});

  @override
  State<HomeScreenChildPage> createState() => _HomeScreenChildPageState();
}

class _HomeScreenChildPageState extends State<HomeScreenChildPage> {
  late final HomeScreenCubit _cubit;
  late final CardSwiperController controller;
  late ConfettiController _confettiController;
  late TextEditingController textMatchController;
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    controller = CardSwiperController();
    _cubit.loadInitialData();
    _cubit.getVipUser();
    _cubit.saveToken();

    if (helpersFunctions.userLongitude != 0) {
      _cubit.getLocation();
    }
    textMatchController = TextEditingController();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 800));
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!(await FirebaseApi().checkLocationPermission()) && internetCheck) {
      AppPopupNotification.dialogGetLocation(
          context: context,
          onChangeLocation: () async {
            _cubit.getLocation();
            _cubit.loadInitialData();
            Navigator.pop(context);
          });
    }
  }

  void _dialogAccelerates(
      {required int count, required Function onAccelerates}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) =>
            BottomAcceleratesModal(count: count, onAccelerates: onAccelerates));
  }

  void _showOverlayConfetti(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
            emissionFrequency: 0.2,
            numberOfParticles: 20,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(_overlayEntry);
  }
  void _hideOverlayConfetti() {
    _overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(context: context, actionsWidget: [
        IconButton(
          onPressed: () {
            context.goNamed(AppRoutes.notification);
          },
          icon: const Icon(
            Icons.notifications_none_rounded,
          ),
        ),
        IconButton(
          onPressed: () {
            context
                .pushNamed(AppRoutes.settingQuery)
                .then((value) => _cubit.loadInitialData());
          },
          icon: const Icon(
            Icons.tune,
          ),
        ),
        SizedBox(
          width: 16.w,
        )
      ]),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        buildWhen: (previous, current) =>
            previous.direction != current.direction,
        builder: (context, state) {
          return helpersFunctions.userLongitude != 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ItemController(
                      iconSvg: 'delete',
                      colors: const [Color(0xFFFC23C8), Color(0xFFF53462)],
                      state: state.direction == CardSwiperDirection.left,
                      onTap: () {
                        controller.swipeLeft();
                      },
                    ),
                    ItemController(
                      iconSvg: 'lightning',
                      size: 55,
                      colors: const [Color(0xFFDC4EEC), Color(0xFFCA50F0)],
                      state: state.direction == CardSwiperDirection.bottom,
                      onTap: () async {
                        context.read<HomeScreenCubit>().state.isVipUser &&
                                context.read<HomeScreenCubit>().state.turnVipUser != 0
                            ? _dialogAccelerates(
                                count: context.read<HomeScreenCubit>().state.turnVipUser,
                                onAccelerates: () async {
                                  if (timeService.hasAccelerate) {
                                    Navigator.pop(context);
                                    AppPopupNotification.showDialogComplete(context, content:S().content_boosts_false,
                                        onSubmit: () {
                                          Navigator.pop(context);
                                        });
                                  } else {
                                    await _cubit.startAccelerate();
                                    _cubit.getVipUser().then((value) {
                                      BlocProvider.of<MainCubit>(context).startAccelerate(accelerate: true);
                                    });
                                    AppPopupNotification.showDialogComplete(context, content:S().content_boosts,
                                        onSubmit: () {
                                          _hideOverlayConfetti();
                                          _confettiController.stop();
                                          Navigator.pop(context);
                                        });
                                    _confettiController.play();
                                    _showOverlayConfetti(context);
                                  }
                                })
                            : context.goNamed(AppRoutes.payment);
                      },
                    ),
                    ItemController(
                      iconSvg: 'heart',
                      colors: const [Color(0xFFBAE517), Color(0xFF42BD49)],
                      state: state.direction == CardSwiperDirection.right,
                      onTap: () {
                        controller.swipeRight();
                      },
                    )
                  ],
                )
              : const SizedBox();
        },
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      bloc: _cubit,
      listenWhen: (previous, current) =>
          previous.followStatus != current.followStatus,
      listener: (context, state) {
        if (state.followStatus == LoadStatus.success) {
          if (state.checkFollower == true) {
            AppPopupNotification.showMatchDialog(context,
                user: state.userMatch!,
                textMatchController: textMatchController,
                controller: _confettiController);
          }
        }
      },
      buildWhen: (previous, current) => previous.loadDataStatus != current.loadDataStatus,
      builder: (context, state) {
        if (state.loadDataStatus == LoadStatus.success) {
          return helpersFunctions.userLongitude == 0
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  child: Icon(
                    Icons.location_off,
                    color: Colors.grey,
                    size: 70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Text(
                    S().textContentRefreshLocation,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: ButtonSubmitPageView(
                      text: S().textButtonRefreshLocation,
                      color: Colors.transparent,
                      onPressed: () async {
                        _cubit.getLocation();
                        _cubit.loadInitialData();
                      }),
                )
              ],
            ),
          )
              : ((state.listUser ?? []).length > 1)
              ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CardSwiper(
                allowedSwipeDirection:
                AllowedSwipeDirection.symmetric(
                    horizontal: true),
                cardBuilder: (context,
                    index,
                    horizontalOffsetPercentage,
                    verticalOffsetPercentage) {

                  return CardDetail(
                    userEntity: state.listUser?[index],
                    locationUser: state.locationsUser?[index],
                    onTap: () async {
                      var data = await GoRouter.of(context)
                          .pushNamed(AppRoutes.detailProfile,
                          extra: state.listUser?[index]);
                      if (data != null) {
                        if ((data as Map<String, dynamic>)['key'] ==
                            'heart') {
                          _cubit.getOne(
                              direction: CardSwiperDirection.right,
                              id: state.listUser?[index].uid ?? "");
                          controller.swipeRight();
                        } else if ((data)['key'] == 'delete') {
                          controller.swipeLeft();
                        }
                      }
                    },
                  );
                },
                controller: controller,
                onSwipe: (previousIndex, currentIndex, direction) async {
                  internetCheck
                      ? await _cubit.getOne(
                      direction: direction,
                      id: state.listUser?[previousIndex].uid ??
                          "")
                      : null;
                  return previousIndex != currentIndex;
                },
                onSwipeDirectionChange:
                    (horizontalDirection, verticalDirection) async {
                  await _cubit.changeDirection(
                      direction: horizontalDirection.name == 'left'
                          ? CardSwiperDirection.left
                          : horizontalDirection.name == 'right'
                          ? CardSwiperDirection.right
                          : CardSwiperDirection.none);
                },
                maxAngle: 60,
                threshold: 100,
                isLoop: true,
                direction: CardSwiperDirection.left,
                cardsCount: state.listUser?.length ?? 0),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "no_data".withImage(),
                width: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  S().listCardEmptyContent,
                  style:
                  const TextStyle(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: ButtonSubmitPageView(
                    text: S().textButtonRefreshLocation,
                    color: Colors.transparent,
                    onPressed: () async {
                      _cubit.loadInitialData();
                    }),
              )
            ],
          );
        }
        return Center(
          child: LoadingAnimationWidget.dotsTriangle(
            color: const Color(0xFFd73730),
            size: 70,
          ),
        );

      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    controller.dispose();
    super.dispose();
  }
}
