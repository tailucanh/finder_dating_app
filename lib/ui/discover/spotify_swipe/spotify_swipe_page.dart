import 'package:chat_app/app.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/discover/spotify_swipe/widgets/card_detail.dart';
import 'package:chat_app/ui/home_screen/widgets/item_controller.dart';
import 'package:chat_app/ui/login/widgets/button_submit_page_view.dart';
import 'package:chat_app/ui/widgets/popup_notification.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'spotify_swipe_cubit.dart';
import 'spotify_swipe_navigator.dart';
import 'spotify_swipe_state.dart';

class SpotifySwipePage extends StatelessWidget {
  const SpotifySwipePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SpotifySwipeCubit(
            navigator: SpotifySwipeNavigator(context: context));
      },
      child: const DiscoverChildPage(),
    );
  }
}

class DiscoverChildPage extends StatefulWidget {
  const DiscoverChildPage({
    super.key,
  });

  @override
  State<DiscoverChildPage> createState() => _DiscoverChildPageState();
}

class _DiscoverChildPageState extends State<DiscoverChildPage> {
  late final SpotifySwipeCubit _cubit;
  late final CardSwiperController controller;
  late ConfettiController _confettiController;
  late TextEditingController textMatchController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    controller = CardSwiperController();
    _cubit.loadInitialData();
    _cubit.saveToken();
    if (helpersFunctions.userLongitude != 0) {
      _cubit.getLocation();
    }
    textMatchController = TextEditingController();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cubit.audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<SpotifySwipeCubit, SpotifySwipeState>(
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
                  controller.swipe(CardSwiperDirection.left);
                },
              ),
              ItemController(
                iconSvg: 'lightning',
                size: 55,
                colors: const [Color(0xFFDC4EEC), Color(0xFFCA50F0)],
                state: state.direction == CardSwiperDirection.bottom,
                onTap: () async {
                  await _cubit.startAccelerate();
                },
              ),
              ItemController(
                iconSvg: 'heart',
                colors: const [Color(0xFFBAE517), Color(0xFF42BD49)],
                state: state.direction == CardSwiperDirection.right,
                onTap: () {
                  controller.swipe(CardSwiperDirection.right);
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
    return BlocConsumer<SpotifySwipeCubit, SpotifySwipeState>(
      bloc: _cubit,
      listenWhen: (previous, current) =>
      current.followStatus == LoadStatus.success,
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
      buildWhen: (previous, current) =>
      previous.loadDataStatus != current.loadDataStatus,
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
                        setState(() {});
                      }),
                )
              ],
            ),
          )
              : ((state.listUser ?? []).length <= 1)
              ? Column(
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  S().listCardEmptyContent,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),

            ],
          )
              : Ink(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(188, 21, 137, 1.0),
                    Color.fromRGBO(33, 162, 23, 1.0),
                  ],
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Ink(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => context.pop(),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 25,
                            color: Colors.white,
                          )),
                      Expanded(
                        child: Center(
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.3)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'spotify'.withIcon(),
                                  width: 17.w,
                                  height: 17.h,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  S().spotifyPlayMusic,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
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
                          locationUser: state.locationUser?[index],
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
                                controller.swipe(CardSwiperDirection.right);
                              } else if ((data)['key'] == 'delete') {
                                controller.swipe(CardSwiperDirection.left);
                              }
                            }
                          },
                        );
                      },
                      controller: controller,
                      onSwipe: (previousIndex, currentIndex,
                          direction) async {
                        internetCheck
                            ? await _cubit.getOne(
                            direction: direction,
                            id: state.listUser?[previousIndex]
                                .uid ??
                                "")
                            : null;
                        _cubit.audioPlayer.setUrl(state
                            .listUser![currentIndex!]
                            .spotify!
                            .previewUrl);

                        _cubit.audioPlayer.play();

                        return previousIndex != currentIndex;
                      },
                      onSwipeDirectionChange: (horizontalDirection,
                          verticalDirection) async {
                        await _cubit.changeDirection(
                            direction: horizontalDirection.name ==
                                'left'
                                ? CardSwiperDirection.left
                                : horizontalDirection.name == 'right'
                                ? CardSwiperDirection.right
                                : CardSwiperDirection.none);
                      },
                      maxAngle: 60,
                      threshold: 100,
                      isLoop: true,
                      cardsCount: state.listUser?.length ?? 0),
                ),
              ],
            ),
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
}
