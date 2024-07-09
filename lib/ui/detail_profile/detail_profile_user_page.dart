import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/detail_profile/detail_profile_user_cubit.dart';
import 'package:chat_app/ui/detail_profile/detail_profile_user_navigator.dart';
import 'package:chat_app/ui/home_screen/widgets/photo_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/helpers/helpers_data_user.dart';
import '../../generated/l10n.dart';
import '../../model/entities/user_entity.dart';

class DetailProfileUser extends StatelessWidget {
  const DetailProfileUser({
    super.key,
    required this.user,
    this.commonInterest,
  });

  final UserEntity user;
  final List<int>? commonInterest;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DetailProfileUserCubit(
          navigator: DetailProfileNavigator(context: context),
        );
      },
      child: DetailProfileUserChildPage(
        user: user,
        commonInterest: commonInterest,
      ),
    );
  }
}

class DetailProfileUserChildPage extends StatefulWidget {
  const DetailProfileUserChildPage(
      {super.key, required this.user, this.commonInterest});

  final UserEntity user;
  final List<int>? commonInterest;

  @override
  State<DetailProfileUserChildPage> createState() =>
      _DetailProfileUserChildPageState();
}

class _DetailProfileUserChildPageState extends State<DetailProfileUserChildPage> {
  late final DetailProfileUserCubit _cubit;
  late TextEditingController controller;
  int tappedButtonIndex = -1;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool _isFabVisible = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    controller = TextEditingController();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(id: widget.user.uid);
  }
  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isFabVisible == true) {
        setState(() {
          _isFabVisible = false;
        });
      }
    } else {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isFabVisible == false) {
          setState(() {
            _isFabVisible = true;
          });
        }
      }
    }
  }


  @override
  void dispose() {
    controller.dispose();
    audioPlayer.stop();
    isPlaying = false;
    super.dispose();
    _cubit.close();
  }

  Future<void> _handleTap(int buttonIndex, Function() onTap) async {
    setState(() {
      tappedButtonIndex = buttonIndex;
    });

    await Future.delayed(const Duration(milliseconds: 100));

    setState(() {
      tappedButtonIndex = -1;
    });

    onTap();
  }

  @override
  Widget build(BuildContext context) {
    String fullName = widget.user.fullName;
    String school = widget.user.school ?? '';
    String currentAddress = widget.user.currentAddress ?? '';
    String company = widget.user.company ?? '';
    String introduceYourself = widget.user.introduceYourself ?? '';
    int datingPurpose = widget.user.datingPurpose ?? -1;
    int height = widget.user.height ?? 0;
    GeoPoint currentLocation = GeoPoint(helpersFunctions.userLatitude, helpersFunctions.userLongitude);

    return Scaffold(
      extendBody: true,
      floatingActionButton:widget.user.uid.contains(helpersFunctions.idUser) ? AnimatedSlide(
        duration: Duration(milliseconds: 300),
        offset: _isFabVisible ? Offset.zero : Offset(2, 0),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: _isFabVisible ? 1 : 0,
          child: InkWell(
            onTap: () =>  context.goNamed(AppRoutes.updateProfile, extra: widget.user),
            child: Container(
              width: 55,
              height: 55,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(234, 64, 128, 1),
                    Color.fromRGBO(238, 128, 95, 1)
                  ],
                ),
              ),
              child: Center(child: Icon(Icons.edit_rounded, size: 30, color: Colors.white,)),
            ),
          ),
        ),
      ): const SizedBox(),
      body: BlocBuilder<DetailProfileUserCubit, DetailProfileUserState>(
        builder: (context, state) {
          int distance = -1;
          if (state.locationUser != null) {
            distance = HelpersDataUser.calculateDistance(currentLocation, state.locationUser!);
          }
          return Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, bottom: 100),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.47,
                      child: Stack(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 1.55,
                              child: PhotoGallery(
                                    user: widget.user,
                                    scrollPhysics: const AlwaysScrollableScrollPhysics(),
                                    currentIndex: 0,
                                    borderRadius: 0,
                                  )),
                          Positioned(
                              bottom: 0,
                              right: 20,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(234, 64, 128, 1),
                                        Color.fromRGBO(238, 128, 95, 1)
                                      ],
                                    ),
                                  ),
                                  child:
                                      Image.asset('arrow-down'.withIconPNG()),
                                ),
                              )),
                          //
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                fullName.length > 13
                                    ? '${fullName.substring(0, 13)}...'
                                    : fullName ?? '',
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                (DateTime.now().year -
                                        int.parse(widget.user.birthday
                                            .substring(0, 4)))
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                child:  Icon(
                                  Icons.verified,
                                  color: state.isProfileVerified ? Colors.blue : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          (currentAddress.isNotEmpty)
                              ? buildInfo(
                                  icon: Icons.home_rounded,
                                  content: '${S().livingIn} ${currentAddress}')
                              : const SizedBox.shrink(),
                          ((state.locationUser != null) && distance < 50 && !widget.user.uid.contains(helpersFunctions.idUser) )
                              ? buildInfo(
                                  icon: Icons.location_on_sharp,
                                  content: "${S().away} ${distance == 0 ? 1 : distance} km")
                              : const SizedBox(),
                          (school.isNotEmpty)
                              ? buildInfo(
                                  icon: Icons.school_rounded,
                                  content: widget.user.school ?? '')
                              : const SizedBox.shrink(),
                          (company.isNotEmpty)
                              ? buildInfo(
                              icon: Icons.location_city_rounded,
                              content: widget.user.company ?? '')
                              : const SizedBox.shrink(),
                          (height > 0)
                              ? buildInfo(
                                  icon: Icons.height_rounded,
                                  content:'${widget.user.height.toString() ?? ''} cm')
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    (introduceYourself.isNotEmpty || datingPurpose != -1)
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 15),
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (datingPurpose != -1)
                                    ? buildDatingPurposeBox(
                                        context, datingPurpose)
                                    : const SizedBox.shrink(),
                                (introduceYourself.isNotEmpty)
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            S().detailProfileIntroduceTitle,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            introduceYourself.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),

                    (widget.user.spotify != null) ?buildSpotifyInfo() : const SizedBox(),

                    (widget.user.interestsList.length > 0)
                        ? generateList(
                        title: S().detailProfileHobbiesTitle,
                        titleIcon: Icons.interests_rounded,
                        list: HelpersDataUser.getItemFromListIndex( HelpersDataUser.interestsList(), widget.user.interestsList),
                        listIcon: [],
                        commonInterest: widget.commonInterest)
                        : const SizedBox.shrink(),


                    (HelpersDataUser.isListNotEmpty(
                            HelpersDataUser.styleOfLifeUsers(widget.user)))
                        ? generateList(
                            title: S().detailProfileLifestyleTitle,
                            titleIcon: Icons.label_important_rounded,
                            list: HelpersDataUser.styleOfLifeUsers( widget.user),
                            listIcon: HelpersDataUser.styleOfLifeUsersIcon,
                        )
                        : const SizedBox.shrink(),
                    (HelpersDataUser.isListNotEmpty(
                            HelpersDataUser.basicInfoUsers(widget.user)))
                        ? generateList(
                            title: S().detailProfileAdditionalMeTitle,
                           titleIcon: Icons.label_important_rounded,
                            list: HelpersDataUser.basicInfoUsers(widget.user),
                            listIcon: HelpersDataUser.basicInfoUsersIcon,
                           )
                        : const SizedBox.shrink(),

                    buildFunctionButton(
                        title: S().detailProfileShareTitle,
                        content: S().detailProfileShareContent,
                        onTap: () async {
                          final box = context.findRenderObject() as RenderBox?;
                          await Share.share('How do you see ${widget.user.fullName}? Download the app and experience it! \n https://play.google.com/store/apps/details?id=com.polyvn.chat_app',
                              sharePositionOrigin:
                                  box!.localToGlobal(Offset.zero) & box.size);
                        }),
                    !widget.user.uid.contains(helpersFunctions.idUser) ?
                    buildFunctionButton(
                        title: '${S().detailProfileReportTitle} $fullName',
                        content: S().detailProfileReportContent,
                        onTap: () {
                          GoRouter.of(context)
                              .pushNamed(AppRoutes.reportUser,extra: widget.user.uid );
                        }): const SizedBox(),
                  ],
                ),
              ),
              (!(state.isMatched ?? false) && !widget.user.uid.contains(helpersFunctions.idUser))
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 15, top: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors:
                                Theme.of(context).brightness == Brightness.light
                                    ? [
                                        Colors.white.withOpacity(0.4),
                                        Colors.white.withOpacity(0.6),
                                        Colors.white.withOpacity(0.8),
                                      ]
                                    : [
                                        Colors.black.withOpacity(0.4),
                                        Colors.black.withOpacity(0.6),
                                        Colors.black.withOpacity(0.8),
                                      ],
                            stops: const [0.2, 0.4, 0.6],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildFloatingButton(
                                'delete'.withIcon(),() {
                              context.pop({'key': 'delete'});
                            }, 0),
                            const SizedBox(width: 20),
                            buildFloatingButton(
                                'heart'.withIcon(), () {
                              context.pop({'key': 'heart'});
                            }, 2),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          );
        },
      ),
    );
  }

  Widget buildInfo({required IconData icon, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget buildFloatingButton(String icon, Function() onTap, int index) {
    return GestureDetector(
      onTap: () {
        _handleTap(index, onTap);
      },
      child: AnimatedContainer(
        width: 55,
        height: 55,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()
          ..scale(tappedButtonIndex == index ? 0.9 : 1.0),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).brightness == Brightness.light
              ? Color(0xFFFEFEFE)
              : Color(0xFFF23262F),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 2,
              offset: const Offset(0.3, -0.5),
            ),
          ],
        ),
        child: SvgPicture.asset(icon, fit: BoxFit.contain),
      ),
    );
  }

  Widget buildFunctionButton(
      {required String title, required String content, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade200,
              width: 0.8,
            ),
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 0.8,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDatingPurposeBox(BuildContext context, int index) {
    String title = HelpersDataUser.getItemFromIndex(HelpersDataUser.datingPurposeList(), index);
    return Container(
        width: MediaQuery.of(context).size.width / 1.4,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (index != -1)
              ? HelpersDataUser.colorBgPurposeList[index]
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (index != -1)
                ? Image.asset(
                    HelpersDataUser.emojiDatingPurposeList[index],
                    width: 30,
                    height: 30,
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S().detailProfileLookingFor,
                  style: TextStyle(
                      color: (index != -1)
                          ? HelpersDataUser.colorTitlePurposeList[index]
                          : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: (index != -1)
                          ? HelpersDataUser.colorTitlePurposeList[index]
                          : Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ));
  }

  Widget buildSpotifyInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.music_note_rounded),
              const SizedBox(width: 5,),
              Text(
                S().spotifyPopularTitle,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 70,
                  height: 70,
                  imageUrl: widget.user.spotify?.albumImageUrl ?? '',
                  placeholder: (context, url) => SvgPicture.asset(
                    "spotify".withIcon(),
                    width: 45.w,
                    height: 45.h,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.spotify!.name,
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SvgPicture.asset(
                              "spotify".withIcon(),
                              width: 12.w,
                              height: 12.h,
                            ),
                          ),
                        ),
                        TextSpan(
                            text: widget.user.spotify!.artist.join(', '),
                            style: TextStyle(color: Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.white, fontSize: 14.sp))
                      ]),
                    ),
                    InkWell(
                        onTap: () async {
                          if (!await launchUrl(Uri.parse(
                              widget.user.spotify!.spotifyExternalUrl))) {
                            debugPrint(
                                'Could not launch ${widget.user.spotify!.spotifyExternalUrl}');
                          }
                        },
                        child: Text(
                          S.current.spotifyPlayMusicAll,
                          style: TextStyle(
                              color: const Color(0XFF00DA5A), fontSize: 14.sp),
                        ))
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (isPlaying) {
                      audioPlayer.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      audioPlayer.setUrl(widget.user.spotify?.previewUrl ?? '');
                      audioPlayer.play();
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 30,
                    color: Colors.green,
                  ))
            ],
          ),
        ],
      ),
    );
  }


  Widget generateList(
      {required String title,
      required IconData titleIcon,
      required List<String> list,
        required List<IconData> listIcon,
      List<int>? commonInterest}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(titleIcon),
              const SizedBox(width: 5,),
              Text(
                title,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              int itemCount = list.length;
              return Wrap(
                children: List.generate(itemCount, (index) {
                  if (list[index].isNotEmpty) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5, right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            width: 1,
                            color: (commonInterest ?? []).length > 0
                                ? HelpersDataUser.getItemFromListIndex(
                                            HelpersDataUser.interestsList(),
                                            commonInterest ?? [])
                                        .contains(list[index])
                                    ? Colors.red
                                    : Colors.grey
                                : Colors.grey),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (listIcon.length > 0) ?
                          Icon(listIcon[index]) : const SizedBox(),

                          SizedBox(width:listIcon.length > 0 ? 5 : 0,),

                          Text(
                            list[index].toString(),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }
}
