import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../generated/l10n.dart';
import '../../services/call_video_service.dart';
import 'discover_cubit.dart';
import 'discover_navigator.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DiscoverCubit(
          navigator: DiscoverNavigator(context: context),
        );
      },
      child: const ChatScreenChildPage(),
    );
  }
}

class ChatScreenChildPage extends StatefulWidget {
  const ChatScreenChildPage({super.key});

  @override
  State<ChatScreenChildPage> createState() => _ChatScreenChildPageState();
}

class _ChatScreenChildPageState extends State<ChatScreenChildPage> {
  late final DiscoverCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        context: context,
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<DiscoverCubit, DiscoverState>(
      builder: (context, state) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5
                  )
                ]
              ),
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('music'.withImage())),
                  Positioned.fill(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                  )),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                          ),
                          onPressed: () async {
                            await _cubit.checkSpotify().then((value) {
                              if (value) {
                                context.pushNamed(AppRoutes.spotifySwipe);
                              } else {
                                context.pushNamed(AppRoutes.chooseSpotifySong);
                              }
                            });
                          },
                          child: Text(
                            S().spotifyPlayButton.toUpperCase(),
                            style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp),
                          ))),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('spotify'.withIcon(), width: 25.w, height: 25.h,),
                              SizedBox(width: 8.w,),
                              const Text(
                                "Spotify",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            "Music Mode",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 33.sp),
                          )
                        ],
                      ))
                ],
              ),
            ),
            _buildProfileVerification(state.isProfileVerified ?? false),
          ],
        ),
      ),
    );
  }


  Widget _buildProfileVerification(bool isProfileVerified) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5)]),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('verification'.withImage())),
          Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
              )),
          isProfileVerified == false
              ? Positioned(
              bottom: 10,
              right: 10,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    context.goNamed(AppRoutes.verifyAvatar);
                  },
                  child: Text(
                    S().verifyAvatarDiscoverTitle_Button.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp),
                  )))
              : const SizedBox(),
          Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                       Image.asset(
                        'verified'.withImage(),
                         width: 30,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      const Text(
                        "Verification",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    isProfileVerified
                        ? S().verifyAvatarDiscoverTitle_Success
                        : S().verifyAvatarDiscoverTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.sp),
                  )
                ],
              ))
        ],
      ),
    );
  }




  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
