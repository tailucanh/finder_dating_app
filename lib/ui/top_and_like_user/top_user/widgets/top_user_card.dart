
import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/detail_profile/detail_profile_user_page.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/widgets/top_user_card_cubit.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/widgets/top_user_card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../generated/l10n.dart';
import '../../../../config/helpers/helpers_data_user.dart';
import '../../../widgets/popup_notification.dart';

class TopUserCard extends StatelessWidget {
  const TopUserCard({super.key, this.user, this.isRecent});

  final UserEntity? user;
  final bool? isRecent;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TopUserCardCubit()..loadInitialData(user!.uid);
      },
      child: TopUserCardChild(user: user, isRecent: isRecent),
    );
  }
}

class TopUserCardChild extends StatefulWidget {
  const TopUserCardChild({super.key, this.user, this.isRecent});

  final UserEntity? user;
  final bool? isRecent;

  @override
  State<TopUserCardChild> createState() => _TopUserCardChildState();
}

class _TopUserCardChildState extends State<TopUserCardChild> {
  late TopUserCardCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TopUserCardCubit>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUserCardCubit, TopUserCardState>(
        builder: (context, state) {
      List<int> commonList = HelpersDataUser.findCommonValues(
          state.currentUser?.interestsList ?? [],
          widget.user?.interestsList ?? []);
      return InkWell(
        onTap: () {
          DetailProfileUser(user: widget.user!);
          context.goNamed(AppRoutes.detailProfile, extra: widget.user);
        },
        child: Stack(children: [
          _buildUserImage(),
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
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 5.0, bottom: 8),
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
                                    Text(
                                      '${widget.user?.fullName ?? ""}, ${DateTime.now().year - int.parse((widget.user?.birthday ?? '').substring(0, 4))}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    (widget.isRecent ?? false)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 8,
                                                height: 8,
                                                margin: const EdgeInsets.only(
                                                    right: 5),
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
                                                  S().topUserRecentActivityTitle,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )
                                        : generateInterestsList(HelpersDataUser
                                            .getItemFromListIndex(
                                                HelpersDataUser.interestsList(),
                                                commonList)),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  AppPopupNotification.showBottomModalVip(
                                    context: context,
                                    packageModel:
                                        HelpersDataUser.packageBinderSuperLike(
                                            context),
                                    isSuperLike: true,
                                    isHaveColor: true,
                                    iconData: Icons.star,
                                    isHaveIcon: true,
                                    iconColor: Colors.blue,
                                    color: Colors.blue[200]!,
                                    title: S().bodyBuyPremiumTitle,
                                    subTitle: S().bodyBuyPremiumContent,
                                  );
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(6),
                                    width: 32,
                                    height: 32,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            'star-around'.withIcon()))),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        ]),
      );
    });
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

  Widget generateInterestsList(List<String> list) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        int itemCount = list.length;
        return Wrap(
          children: List.generate(itemCount, (index) {
            if (list[index].isNotEmpty) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 3, right: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 0.5),
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.grey700,
                  ),
                  child: Text(
                    list[index].toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                  ));
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      }),
    );
  }
}
