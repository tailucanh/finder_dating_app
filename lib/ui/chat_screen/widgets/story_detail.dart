import 'dart:math';

import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/model/entities/story.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../../config/helpers/helpers_data_user.dart';
import '../../widgets/app_cache_avatar.dart';

class StoryDetail extends StatefulWidget {
  const StoryDetail({super.key, this.storyList,this.name,this.avatar,this.activeStatus});

  final List<Story>? storyList;
  final String? name;
  final String? avatar;
  final bool? activeStatus;

  @override
  State<StoryDetail> createState() => _StoryDetailState();
}

class _StoryDetailState extends State<StoryDetail> {
  late VideoPlayerController controller;
  int _currentVideoIndex = 0;
  late ConfettiController  _confettiController;


  @override
  void initState() {
    _confettiController = ConfettiController(duration: const Duration(milliseconds: 800));
    controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.storyList?[_currentVideoIndex].url ?? ""))
      ..initialize().then((value) => controller.play());
    controller.addListener(
      () {
        _videoPlayerListener();
      },
    );
    super.initState();
  }

  void _videoPlayerListener() {
    if (controller.value.position >= controller.value.duration) {
      // Video đã kết thúc, chuyển sang video tiếp theo
      if (!mounted) return;
      setState(() {
        if ((widget.storyList?.length ?? 0) > 1 && _currentVideoIndex <= (widget.storyList?.length ?? 0)) {
          _currentVideoIndex = _currentVideoIndex + 1;
          controller = VideoPlayerController.networkUrl(
              Uri.parse(widget.storyList?[_currentVideoIndex].url ?? ""))
            ..initialize().then((_) {
              controller.play();
            });
          controller.addListener(
            () {
              _videoPlayerListener();
            },
          );
        } else {
            context.pop();
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              VideoPlayer(controller),
              Positioned(
                top: 8,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Colors.white,
                        backgroundColor: Colors.black12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppCacheAvatar(
                                linkAvatar: widget.avatar,
                                status: widget.activeStatus ?? false,
                                size: 40,
                                isCardStory: true,
                              ),
                              const SizedBox(width: 10,),
                              Text(widget.name ??'',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 17),maxLines: 2,),
                              const SizedBox(width: 5,),
                              Text( HelpersDataUser.strCalculateTimeDifference(int.parse(widget.storyList?[_currentVideoIndex].createAt ?? '')).toString(),
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400,fontSize: 15),),
                            ],
                          ),
                          IconButton(
                              onPressed: () => context.pop(),
                              icon:  SvgPicture.asset(
                                'delete'.withIcon(),
                                width: 30,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi / 2,
                  maxBlastForce: 5,
                  minBlastForce: 1,
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  gravity: 0,
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 10),
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 10,
                        children:  List.generate(HelpersDataUser.emojiDialogMatch.length, (index) {
                          final item = HelpersDataUser.emojiDialogMatch[index];
                          return  InkWell(
                            onTap: (){
                              _confettiController.play();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width:  1,
                                  color:  Colors.grey.shade300,
                                ),
                              ),
                              child: Text(item, style: const TextStyle(fontSize: 18,),textAlign: TextAlign.center,),
                            ),
                          );
                        }),
                      )
                    )
                ),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    controller.removeListener(_videoPlayerListener);
    controller.dispose();
    super.dispose();
  }
}
