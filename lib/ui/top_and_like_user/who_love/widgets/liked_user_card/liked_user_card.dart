import 'dart:ui';

import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/top_and_like_user/who_love/widgets/liked_user_card/liked_user_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/helpers/helpers_data_user.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/popup_notification.dart';
import '../../who_love_cubit.dart';
import 'liked_user_card_state.dart';

class LikedUserCard extends StatelessWidget {
  const LikedUserCard({super.key, this.user, required this.isUserGold});

  final UserEntity? user;
  final bool isUserGold;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LikedUserCardCubit()..loadInitialData(user!.uid);
      },
      child: LikedUserCardChild(
        user: user,
        isUserGold: isUserGold,
      ),
    );
  }
}

class LikedUserCardChild extends StatefulWidget {
  const LikedUserCardChild({super.key, this.user, required this.isUserGold});
  final bool isUserGold;
  final UserEntity? user;

  @override
  State<LikedUserCardChild> createState() => _LikedUserCardChildState();
}

class _LikedUserCardChildState extends State<LikedUserCardChild> {
  late LikedUserCardCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<LikedUserCardCubit>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cubit.close();
  }

  void _popupVip() {
    AppPopupNotification.showBottomModalVip(
      context: context,
      color: Colors.yellowAccent,
      title: "Finder",
      isHaveIcon: false,
      packageModel: HelpersDataUser.packageBinderGoldList(context),
      assetsBanner: 'ic_tinder_logo'.withImage(),
      assetsIcon: 'ic_tinder_logo'.withImage(),
      isHaveColor: true,
      subTitle: S().sliderCustomSubTitle2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedUserCardCubit, LikedUserCardState>(
      builder: (context, state) => InkWell(
        onTap: () {
          widget.isUserGold
              ? context.goNamed(AppRoutes.detailProfile, extra: widget.user)
              : _popupVip();
        },
        child: Stack(children: [
          _buildUserImage(),
          !widget.isUserGold
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                )
              : const SizedBox(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(1)],
                  stops: const [0.5, 1],
                ),
              ),
              child: state.loadDataStatus == LoadStatus.success
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.isUserGold
                                        ? Text(
                                          '${widget.user?.fullName ?? ""}, ${DateTime.now().year - int.parse((widget.user?.birthday ?? '').substring(0, 4))}' ,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 10,
                                                margin: const EdgeInsets.only(
                                                    bottom: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                              ),
                                              Container(
                                                width: 75,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade500,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                              ),
                                            ],
                                          ),
                                    (widget.user?.activeStatus ?? false)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 8,
                                                height: 8,
                                                margin: const EdgeInsets.only(right: 5),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const CircleAvatar(
                                                  backgroundColor:
                                                      Colors.greenAccent,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  S().active,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                              (state.isMatched ?? false) && widget.isUserGold
                                  ? InkWell(
                                      onTap: () {
                                        context.goNamed(AppRoutes.detailChat,
                                            queryParameters: {
                                              'idChat': state.idChat,
                                              'idUser': widget.user?.uid,
                                            });
                                      },
                                      child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Container(
                                            child: const Icon(
                                              Icons.chat_bubble_rounded,
                                              color: Colors.blueAccent,
                                              size: 20,
                                            ),
                                          )),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        !(state.isMatched ?? false) && widget.isUserGold
                            ? Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        await cubit
                                            .removeFollower(
                                                widget.user?.uid ?? '')
                                            .then((value) =>
                                                BlocProvider.of<WhoLoveCubit>(
                                                        context)
                                                    .loadInitialData());
                                      },
                                      icon: const Icon(
                                        Icons.clear_rounded,
                                        color: Colors.red,
                                      )),
                                  Container(
                                    width: 1,
                                    height: 20, // Adjust height as needed
                                    color: Colors.white,
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await cubit
                                            .followUser(widget.user!.uid);
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.greenAccent,
                                      ))
                                ],
                              )
                            : const SizedBox(
                                height: 15,
                              ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildUserImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade300
                : Colors.grey.shade800,
            blurRadius: 4,
          ),
        ],
        image: DecorationImage(
          image: (widget.user?.avatar ?? '').isNotEmpty
              ? NetworkImage(widget.user?.avatar ?? '')
              : const NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

