import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/ui/chat_screen/chat_screen_page.dart';
import 'package:chat_app/ui/discover/discover_page.dart';
import 'package:chat_app/ui/home_screen/home_screen_page.dart';
import 'package:chat_app/ui/profile_screen/profile_screen_page.dart';
import 'package:chat_app/ui/top_and_like_user/main_top_and_like.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum MainTab {
  home,
  discover,
  topAndLike,
  chats,
  profile,
}

extension MainTabExtension on MainTab {
  Widget get page {
    switch (this) {
      case MainTab.home:
        return const HomeScreenPage();
      case MainTab.discover:
        return const DiscoverPage();
      case MainTab.topAndLike:
        return const MainTopAndLikePage();
      case MainTab.chats:
        return const ChatScreenPage();
      case MainTab.profile:
        return const ProfileScreenPage();
    }
  }

  BottomNavigationBarItem tab({int? index}) {
    switch (this) {
      case MainTab.home:
        return BottomNavigationBarItem(
          icon: Opacity(
            opacity: index == 0 ? 1 : 0.3,
            child: Image.asset(
              'ic_tinder_logo'.withImage(),
              width: 30,
            ),
          ),
          label: "",
        );
      case MainTab.discover:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset('ic_card'.withIcon(),
              colorFilter: ColorFilter.mode(
                  index == 1 ? AppColors.primaryColor : Colors.black38,
                  BlendMode.dstIn)),
          label: "",
        );
      case MainTab.topAndLike:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'ic_indicator'.withIcon(),
            colorFilter: ColorFilter.mode(
                index == 2 ? AppColors.primaryColor : Colors.black38,
                BlendMode.dstIn),
          ),
          label: "",
        );
      case MainTab.chats:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset('ic_message'.withIcon(),
              colorFilter: ColorFilter.mode(
                  index == 3 ? AppColors.primaryColor : Colors.black38,
                  BlendMode.dstIn)),
          label: "",
        );

      case MainTab.profile:
        return BottomNavigationBarItem(
          icon: SvgPicture.asset('ic_people'.withIcon(),
              colorFilter: ColorFilter.mode(
                  index == 4 ? AppColors.primaryColor : Colors.black38,
                  BlendMode.dstIn)),
          label: "",
        );
    }
  }

  String get title {
    switch (this) {
      case MainTab.home:
        return 'Home';
      case MainTab.discover:
        return 'Discover';
      case MainTab.topAndLike:
        return 'Who Love';
      case MainTab.chats:
        return 'Chats';
      case MainTab.profile:
        return 'Profile';
    }
  }
}
