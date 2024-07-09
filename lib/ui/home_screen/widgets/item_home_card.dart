import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/ui/home_screen/widgets/indicator_painter.dart';
import 'package:chat_app/ui/widgets/app_cache_image.dart';
import 'package:flutter/material.dart';

class ItemHomeCard extends StatefulWidget {
  final UserEntity user;
  final Function()? onTap;
  final int distance;

  const ItemHomeCard(
      {super.key,
      required this.user,
      this.onTap,
      this.distance = -1,
    });

  @override
  _ItemHomeCardState createState() => _ItemHomeCardState();
}

class _ItemHomeCardState extends State<ItemHomeCard> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }


  @override
  Widget build(BuildContext context) {
    bool isActive = widget.user.activeStatus ?? false;
    String name = widget.user.fullName.toString();
    String school = widget.user.school.toString();
    String currentAddress = widget.user.currentAddress.toString();
    int height = widget.user.height ?? 0;
    String introduceYourself = widget.user.introduceYourself.toString();


    return SizedBox(
      child: Stack(
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  } else if (tapPositionX >= halfScreenWidth &&
                      currentIndex < widget.user.photoList.length - 1) {
                    setState(() {
                      currentIndex++;
                    });
                    pageController.animateToPage(
                      currentIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                child: (widget.user.photoList.isNotEmpty)
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
                padding: const EdgeInsets.only(top: 10, left: 10,right: 10,bottom: 40),
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
                                '${name.substring(0,15)}...': name ?? '',
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
                          onTap: widget.onTap,
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

                    (school.isNotEmpty && currentIndex == 0) ?
                    buildInfo(icon: Icons.school_rounded,content: school) : const SizedBox(),


                    (introduceYourself.isNotEmpty && currentIndex == 1)  ?
                    SizedBox(
                      child: Text(introduceYourself,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ) : const SizedBox(),

                    ((widget.user.interestsList.isNotEmpty && introduceYourself.isNotEmpty && currentIndex == 2) || introduceYourself.isEmpty && currentIndex == 1)
                        ? generateList (
                        listData: HelpersDataUser.getItemFromListIndex( HelpersDataUser.interestsList(),  widget.user.interestsList),
                        listIcon: []
                    ) : const SizedBox.shrink(),


                    ((HelpersDataUser.isListNotEmpty(HelpersDataUser.basicInfoUsers(widget.user)) && introduceYourself.isNotEmpty && currentIndex == 3)
                        || (HelpersDataUser.isListNotEmpty(HelpersDataUser.basicInfoUsers(widget.user)) && introduceYourself.isEmpty && currentIndex == 2))
                        ? generateList (
                        listData: HelpersDataUser.basicInfoUsers(widget.user),
                        listIcon: HelpersDataUser.basicInfoUsersIcon) : const SizedBox.shrink(),

                    ((HelpersDataUser.isListNotEmpty(HelpersDataUser.styleOfLifeUsers(widget.user))&& introduceYourself.isNotEmpty && currentIndex == 4)
                        || (HelpersDataUser.isListNotEmpty(HelpersDataUser.styleOfLifeUsers(widget.user)) && introduceYourself.isEmpty && currentIndex == 3))
                        ? generateList (
                        listData: HelpersDataUser.styleOfLifeUsers(widget.user),
                        listIcon: HelpersDataUser.styleOfLifeUsersIcon) : const SizedBox.shrink(),

                    (height > 0 && currentIndex == 5) ?
                    buildInfo(icon: Icons.height_rounded,content: '${height}cm') : const SizedBox(),
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
              margin: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
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
          ): const SizedBox.shrink(),

        ],
      ),
    );
  }

  Widget buildInfo({required IconData icon, required String content}) {
    return Ink(
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
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors:  [
            Color(0xFF308069),
            Color(0xFF187483),
          ],
        ),
      ),
      child:  Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 2.0, horizontal: 10),
        child: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget generateList({
    required List<String> listData,
    required List<IconData> listIcon,
    }) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        int maxRowCount = 2;
        int defaultItemIndex = maxRowCount * 2 - 1;
        int itemCount = listData.length;
        return Wrap(
          children: List.generate(itemCount, (index) {
            if (index < defaultItemIndex && listData[index].isNotEmpty) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 3, right: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.grey700,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (listIcon.length > 0) ?
                      Icon(listIcon[index],size: 15,) : const SizedBox(),

                      SizedBox(width:listIcon.length > 0 ? 3 : 0,),

                      Text(
                        listData[index].toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ));
            } else if (index == defaultItemIndex) {
              return InkWell(
                onTap: widget.onTap,
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
