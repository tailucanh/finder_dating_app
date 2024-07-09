import 'dart:io';

import 'package:chat_app/model/enums/load_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import 'create_story_cubit.dart';
import 'create_story_navigator.dart';

class CreateStoryPage extends StatelessWidget {
  const CreateStoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CreateStoryCubit(
          navigator: CreateStoryNavigator(context: context),
        );
      },
      child: CreateStoryChildPage(
          path: (ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>)['path']),
    );
  }
}

class CreateStoryChildPage extends StatefulWidget {
  const CreateStoryChildPage({super.key, this.path});

  final String? path;

  @override
  State<CreateStoryChildPage> createState() => _CreateStoryChildPageState();
}

class _CreateStoryChildPageState extends State<CreateStoryChildPage> {
  late final CreateStoryCubit _cubit;
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    controller = VideoPlayerController.file(File(widget.path ?? ""),
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: true,
        ))
      ..initialize().then(
        (value) {
          setState(() {});
        },
      );
    controller.play();
    controller.addListener(() {
      if (controller.value.isCompleted) {
        controller.seekTo(Duration.zero);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
                color: Colors.black,
                height: 50,
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                child: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.snippet_folder))),
            Expanded(
              child: VideoPlayer(
                controller,
              ),
            ),
          ],
        ),
        Positioned(
            bottom: 30.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () async {
                await _cubit.createVideoStory(video: File(widget.path ?? ""));
              },
              child: Container(
                height: 45.h,
                width: 120.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue.shade500),
                child: const Text(
                  "Create",
                ),
              ),
            )),
        BlocConsumer<CreateStoryCubit, CreateStoryState>(
          listener: (context, state) {
            if (state.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Create story success')));
              context.pop();
            }
            if (!state.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Create story false')));
              context.pop();
            }
          },
          listenWhen: (previous, current) =>
              previous.success != current.success,
          buildWhen: (previous, current) =>
              previous.loadDataStatus != current.loadDataStatus,
          builder: (context, state) {
            return state.loadDataStatus == LoadStatus.loading
                ? Container(
                    color: Colors.black45.withOpacity(0.5),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : const SizedBox();
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _cubit.close();
    controller.dispose();
    super.dispose();
  }
}
