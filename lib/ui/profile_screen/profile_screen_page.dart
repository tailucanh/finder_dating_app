import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/profile_screen/widgets/body_buy_premium.dart';
import 'package:chat_app/ui/profile_screen/widgets/profile_avatar.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import 'profile_screen_cubit.dart';
import 'profile_screen_navigator.dart';

class ProfileScreenPage extends StatelessWidget {
  const ProfileScreenPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileScreenCubit(
          navigator: ProfileScreenNavigator(context: context),
        );
      },
      child: const ProfileScreenChildPage(),
    );
  }
}

class ProfileScreenChildPage extends StatefulWidget {
  const ProfileScreenChildPage({super.key});

  @override
  State<ProfileScreenChildPage> createState() => _ProfileScreenChildPageState();
}

class _ProfileScreenChildPageState extends State<ProfileScreenChildPage> {
  late final ProfileScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(context: context, actionsWidget: [
        IconButton(
            onPressed: () {
              _cubit.goToSetting();
            },
            icon: const Icon(
              Icons.settings_rounded,
              size: 30,
            )),
        const SizedBox(
          width: 10,
        )
      ]),
      body: SafeArea(
        child: _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
              builder: (context, state) {
                return state.loadDataStatus != LoadStatus.success
                    ? _loadingData()
                    : Column(
                        children: [
                          _buildUserAvatar(state.user),
                          _buildUserName(
                              name: state.user?.fullName ?? "",
                              birthday: state.user?.birthday ?? "",
                              isProfileVerified:
                              state.isProfileVerified ?? false),
                        ],
                      );
              },
              listener: (BuildContext context, Object? state) {},
            ),
            const BodyBuyPremium(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar(UserEntity? user) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(
            avatarUrl: user?.avatar ?? "",
            onEdit: () {
              context.goNamed(AppRoutes.updateProfile, extra: user);
            }, onDetail: () {
            context.goNamed(AppRoutes.detailProfile,
                extra: user);
          },
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }

  Widget _buildUserName({required String name, required String birthday, bool isProfileVerified = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$name, ${(DateTime.now().year - int.parse(birthday.substring(0, 4))).toString()}",
            style: const TextStyle(
                fontWeight: FontWeight.w500, letterSpacing: 1, fontSize: 20),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            child:  Icon(
              Icons.verified,
              color: isProfileVerified ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  _loadingData() => Center(
    child: Shimmer.fromColors(
          baseColor: Colors.black12,
          highlightColor: Colors.white,
          child: Container(
            height: 140.h,
            width: 140.h,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
                color: Colors.white30),
          )),
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
