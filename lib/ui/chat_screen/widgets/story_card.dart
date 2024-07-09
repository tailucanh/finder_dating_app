import 'dart:developer';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/params/story_card.dart';
import 'package:chat_app/ui/widgets/app_cache_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../generated/l10n.dart';

class StoryCardView extends StatefulWidget {
  const StoryCardView({super.key, this.model, this.onTap});

  final Function()? onTap;
  final StoryCard? model;

  @override
  State<StoryCardView> createState() => _StoryCardViewState();
}

class _StoryCardViewState extends State<StoryCardView> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    log('message video ${widget.model?.listStory?.length}');
    if((widget.model?.listStory?? []).isNotEmpty){
      controller = VideoPlayerController.networkUrl(
          Uri.parse('${widget.model?.listStory?[0].url}'))
        ..initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.model?.listStory?? []).isNotEmpty ? Stack(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            height: 160.h,
            width: 110.w,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black26.withOpacity(0.1)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller)),
            ),
          ),
        ),
        Positioned(
          top: 8.h,
          left: 8.w,
          child: AppCacheAvatar(
            linkAvatar: widget.model?.avatar,
            status: widget.model?.activeStatus ?? false,
            size: 40,
            isCardStory: true,
          ),
        ),
        Positioned(
          bottom: 8.h,
          left: 5.w,
          right: 5.w,
          child: Text(((widget.model?.idUser ?? '').contains(helpersFunctions.idUser)) ? S().myStoryTitle : (widget.model?.name ??'') ,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 12),maxLines: 2,),
        )
      ],
    ) : const SizedBox();
  }
}
