import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/discover/spotify_swipe/spotify_swipe_cubit.dart';
import 'package:chat_app/ui/home_screen/widgets/indicator_painter.dart';
import 'package:chat_app/ui/widgets/app_cache_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemMusicCard extends StatefulWidget {
  final UserEntity user;
  final Function onTap;
  final int distance;

  const ItemMusicCard(
      {super.key,
        required this.user,
        required this.onTap,
        this.distance = -1,
      });


  @override
  _ItemMusicCardState createState() => _ItemMusicCardState();
}

class _ItemMusicCardState extends State<ItemMusicCard> {
  PageController pageController = PageController();
  int currentIndex = 0;
  int distance = -1;
  late SpotifySwipeCubit _cubit;


  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SpotifySwipeCubit>(context);
    pageController = PageController(initialPage: currentIndex);
    //BlocProvider.of<HomeScreenCubit>(context).getLocationById(id: widget.user.uid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    bool isActive = widget.user.activeStatus ?? false;
    String name = widget.user.fullName.toString();
    String currentAddress = widget.user.currentAddress.toString();
    int height = widget.user.height ?? 0;
    String introduceYourself = widget.user.introduceYourself.toString();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            itemCount: widget.user.photoList.length,
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTapUp: (TapUpDetails details) {
                  final double tapPositionX = details.localPosition.dx;
                  final double screenWidth = MediaQuery.of(context).size.width;
                  final double halfScreenWidth = screenWidth / 2;

                  if (tapPositionX < halfScreenWidth && currentIndex > 0) {
                    setState(() {
                      currentIndex--;
                    });
                    pageController.animateToPage(
                      currentIndex,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  } else if (tapPositionX >= halfScreenWidth &&
                      currentIndex < widget.user.photoList.length - 1) {
                    setState(() {
                      currentIndex++;
                    });
                    pageController.animateToPage(
                      currentIndex,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                child: (widget.user.photoList.length != 0)
                    ? AppCacheImage(
                  url: widget.user.photoList[index],
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.7,
                  borderRadius: 10,
                )
                    : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image:  DecorationImage(
                      image: AssetImage('ic_tinder_logo'.withImage()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(1),
                  ],
                  stops: const [0.05, 0.4, 0.6, 1.0],
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 10,right: 10,bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (currentIndex == 0 && isActive) ?
                    buildStatus(content: S().active) : const SizedBox(),

                    (widget.distance != -1 && widget.distance < 50 && !isActive && currentIndex == 0)
                        ?  buildStatus(content: S().around)
                        : const SizedBox(),

                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                name.length > 15 ?
                                name.substring(0,15)+'...': name ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                (DateTime.now().year -
                                    int.parse(widget.user.birthday.substring(0, 4)))
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            widget.onTap();
                            _cubit.audioPlayer.stop();
                            _cubit.emitState(_cubit.state.copyWith(isPlaying: false));
                          },

                          child: Container(
                            width: 30,
                            height: 30,
                            decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.5),
                                border: Border.all(color: Colors.grey,width: 0.7)
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Image.asset('arrow-up'.withIconPNG(), color: Colors.grey.shade300,),
                          ),
                        )
                      ],
                    ),



                    (currentAddress.isNotEmpty && currentIndex == 0) ?
                    buildInfo(icon: Icons.home_rounded,content: '${S().livingIn} ${currentAddress ?? ""}') : const SizedBox(),

                    (widget.distance != -1 && widget.distance < 50 && currentIndex == 0)
                        ?  buildInfo(icon: Icons.location_on_sharp,content: "${S().away} ${widget.distance == 0 ? 1 : widget.distance} km")
                        : const SizedBox(),

                    (widget.user.spotify != null && currentIndex == 0) ?
                        buildSpotifyInfo() : const SizedBox(),


                    (introduceYourself.isNotEmpty && currentIndex == 1)  ?
                    SizedBox(
                      child: Text(introduceYourself,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ) : SizedBox(),

                    (widget.user.interestsList.length > 0 && currentIndex == 2)
                        ? generateList (HelpersDataUser.getItemFromListIndex( HelpersDataUser.interestsList(),  widget.user.interestsList)) : SizedBox.shrink(),

                    (height > 0 && currentIndex == 5) ?
                    buildInfo(icon: Icons.height_rounded,content: '${height}cm') : SizedBox(),

                    (HelpersDataUser.isListNotEmpty(HelpersDataUser.basicInfoUsers(widget.user)) && currentIndex == 3)
                        ? generateList (HelpersDataUser.basicInfoUsers(widget.user)) : SizedBox.shrink(),

                    (HelpersDataUser.isListNotEmpty(HelpersDataUser.styleOfLifeUsers(widget.user)) && currentIndex == 4)
                        ? generateList (HelpersDataUser.styleOfLifeUsers(widget.user)) : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),

          (widget.user.photoList.length > 1) ?
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 8.0, left: 15, right: 15),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double indicatorWidth = constraints.maxWidth / widget.user.photoList.length;
                  return FractionallySizedBox(
                    widthFactor: 1,
                    child: CustomPaint(
                      painter: IndicatorPainter(
                        itemCount: widget.user.photoList.length,
                        currentIndex: currentIndex,
                        indicatorWidth: indicatorWidth,
                      ),
                    ),
                  );
                },
              ),
            ),
          ): SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget buildSpotifyInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          StreamBuilder<Duration>(
              stream: _cubit.audioPlayer.positionStream,
              builder: (context, snapshot) {
                int currentPosition = snapshot.data?.inMilliseconds ?? 0;
                int duration = _cubit.state.songDurationInMillisecond ?? 0;
                if (currentPosition == duration) {
                  _cubit.audioPlayer.stop();
                  _cubit.emitState(_cubit.state.copyWith(isPlaying: false));
                }
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          imageUrl: widget.user.spotify!.albumImageUrl),
                    ),
                    Positioned.fill(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 2,
                            value: currentPosition / duration,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          )),
                    ),
                    Positioned.fill(
                      child: Center(
                          child: IconButton(
                            onPressed: () {
                              if (currentPosition == duration) {
                                _cubit.audioPlayer.seek(Duration.zero);
                                _cubit.audioPlayer.play();
                                _cubit.emitState(
                                    _cubit.state.copyWith(isPlaying: true));
                              } else {
                                if (_cubit.state.isPlaying!) {
                                  _cubit.audioPlayer.pause();
                                  _cubit.emitState(_cubit.state.copyWith(isPlaying: false));
                                } else {
                                  _cubit.audioPlayer.play();
                                  _cubit.emitState(
                                      _cubit.state.copyWith(isPlaying: true));
                                }
                              }
                            },
                            icon: Icon(
                              _cubit.state.isPlaying!
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                );
              }),
          SizedBox(width: 16.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.spotify!.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
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
                      style: TextStyle(color: Colors.white, fontSize: 16.sp))
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
        ],
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
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget buildStatus({required String content}){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors:  [
            Color(0xFF308069),
            Color(0xFF187483),
          ],
        ),
      ),
      child:  Padding(
        padding: EdgeInsets.symmetric(
            vertical: 2.0, horizontal: 10),
        child: Text(
          content,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget generateList(List<String> list) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            int maxRowCount = 2;
            int defaultItemIndex = maxRowCount * 2 - 1;
            int itemCount = list.length;
            return Wrap(
              children: List.generate(itemCount, (index) {
                if (index < defaultItemIndex && list[index].isNotEmpty) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 3, right: 5),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.grey700,
                      ),
                      child: Text(
                        list[index].toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ));
                } else if (index == defaultItemIndex) {
                  return InkWell(
                    onTap: (){
                      widget.onTap();
                      _cubit.audioPlayer.stop();
                      _cubit.emitState(_cubit.state.copyWith(isPlaying: false));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 3, right: 5),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color:AppColors.grey700,
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: Text(
                        S().textShowMore,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }).toList(),
            );
          }),
    );
  }
}
