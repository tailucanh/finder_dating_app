import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../../widgets/app_cache_avatar.dart';

class ItemMessage extends StatefulWidget {
  final String param;
  final String time;
  final String imageUrl;
  final String audioUrl;
  final int type;
  final String avatarTarget;
  final bool activeStatus;
  final VoidCallback? onPressed;
  final bool right;

  const ItemMessage({
    super.key,
    this.right = false,
    required this.param,
    required this.avatarTarget,
    required this.activeStatus,
    this.onPressed,
    required this.time,
    required this.type,
    required this.imageUrl,
    required this.audioUrl,
  });

  @override
  State<ItemMessage> createState() => _ItemMessageState();
}

class _ItemMessageState extends State<ItemMessage> {
  bool showTime = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showTime = !showTime;
        });
      },
      child: Column(
        children: [
          if (showTime)
            AnimatedAlign(
                duration: const Duration(milliseconds: 500),
                alignment: Alignment.center,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
                  child: Text(
                    widget.time,
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey
                            : Colors.black54,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700),
                  ),
                )),
          Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5),
            margin: EdgeInsets.only(
              left: widget.right ? 0 : 70.w,
              right: widget.right ? 70.w : 0,
            ),
            child: Align(
              alignment: widget.right ? Alignment.topLeft : Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: widget.right
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      widget.right
                          ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: AppCacheAvatar(
                          linkAvatar: widget.avatarTarget,
                          status: widget.activeStatus,
                          size: 40,
                          isCardStory: true,
                        ),
                      )
                          : const SizedBox(),
                      Flexible(child: _buildMessageContent(context)),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    if (widget.type == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          width: 200.w,
          imageUrl: widget.imageUrl,
          placeholder: (context, url) {
            return Shimmer.fromColors(
                baseColor: Colors.black12,
                highlightColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10)),
                  width: 200.w,
                  height: 150.h,
                ));
          },
        ),
      );
    }
    if (widget.type == 2) {
      return SizedBox(
        width: double.infinity,
        child: FittedBox(
          child: VoiceMessageView(
            activeSliderColor: Colors.white,
            backgroundColor: widget.right ? Colors.grey.shade300 : Colors.blue,
            counterTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            circlesTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            controller: VoiceController(
              audioSrc: widget.audioUrl,
              maxDuration: const Duration(minutes: 5),
              isFile: false,
              onComplete: () {},
              onPause: () {},
              onPlaying: () {},
              onError: (err) {},
            ),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: widget.right ? Colors.grey.shade300 : Colors.blue,
          borderRadius: BorderRadius.only(
              topRight: const Radius.circular(30),
              topLeft: const Radius.circular(30),
              bottomLeft: widget.right
                  ? const Radius.circular(8)
                  : const Radius.circular(30),
              bottomRight: widget.right
                  ? const Radius.circular(30)
                  : const Radius.circular(8))),
      child: Text(widget.param.trim(),
          softWrap: true,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500)),
    );
  }
}
