import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/ui/home_screen/widgets/indicator_painter.dart';
import 'package:flutter/material.dart';
import '../../../model/entities/user_entity.dart';
import '../../widgets/app_cache_image.dart';

class PhotoGallery extends StatefulWidget {
  final UserEntity user;
  int currentIndex;
  final double borderRadius;
  final ScrollPhysics scrollPhysics;

   PhotoGallery(
      {super.key,
      required this.user,
      required this.currentIndex,
      required this.scrollPhysics,
      required this.borderRadius,
      });

  @override
  _ItemHomeCardState createState() => _ItemHomeCardState();
}

class _ItemHomeCardState extends State<PhotoGallery> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.currentIndex);

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          PageView.builder(
            physics: widget.scrollPhysics,
            controller: pageController,
            itemCount: widget.user.photoList.length,
            onPageChanged: (int page) {
              setState(() {
                widget.currentIndex = page;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTapUp: (TapUpDetails details) {
                  final double tapPositionX = details.localPosition.dx;
                  final double screenWidth = MediaQuery.of(context).size.width;
                  final double halfScreenWidth = screenWidth / 2;

                  if (tapPositionX < halfScreenWidth && widget.currentIndex > 0) {
                    setState(() {
                      widget.currentIndex--;
                    });
                    pageController.animateToPage(
                      widget.currentIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  } else if (tapPositionX >= halfScreenWidth &&
                      widget.currentIndex < widget.user.photoList.length - 1) {
                    setState(() {
                      widget.currentIndex++;
                    });
                    pageController.animateToPage(
                      widget.currentIndex,
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
                        borderRadius: widget.borderRadius,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.borderRadius),
                          image:  DecorationImage(
                            image: AssetImage('ic_tinder_logo'.withImage()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              );
            },
          ),
          (widget.user.photoList.length > 1) ?
          Container(
            margin: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double indicatorWidth = constraints.maxWidth / widget.user.photoList.length;
                return FractionallySizedBox(
                  widthFactor: 1,
                  child: CustomPaint(
                    painter: IndicatorPainter(
                      itemCount: widget.user.photoList.length,
                      currentIndex: widget.currentIndex,
                      indicatorWidth: indicatorWidth,
                    ),
                  ),
                );
              },
            ),
          ): const SizedBox.shrink(),
        ],
      ),
    );
  }



}
