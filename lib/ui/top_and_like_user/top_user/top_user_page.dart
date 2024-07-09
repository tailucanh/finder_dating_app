import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/top_user_cubit.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/top_user_navigator.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/top_user_state.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/widgets/fullPages/full_top_user_interest_page.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/widgets/fullPages/full_top_user_recent_page.dart';
import 'package:chat_app/ui/top_and_like_user/top_user/widgets/top_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../generated/l10n.dart';
import '../../../model/entities/user_entity.dart';
import '../../../model/enums/load_state.dart';

class TopUserPage extends StatelessWidget {
  const TopUserPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TopUserCubit(navigator: TopUserNavigator(context: context));
      },
      child: const TopUserChildPage(),
    );
  }
}

class TopUserChildPage extends StatefulWidget {
  const TopUserChildPage({
    super.key,
  });

  @override
  State<TopUserChildPage> createState() => _TopUserChildPageState();
}

class _TopUserChildPageState extends State<TopUserChildPage> {
  late final TopUserCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialRecentActive();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 20),
                  child: Text(S().topUserRecentActivityTitle, style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                ),
                BlocBuilder<TopUserCubit, TopUserState>(
                    builder: (context, state) {
                      if (state.loadDataStatus == LoadStatus.success) {
                        return (state.usersListRecent ?? []).isNotEmpty
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GridView.builder(
                                  itemCount: 2,
                                  shrinkWrap: true,
                                  addAutomaticKeepAlives: false,
                                  physics: const ScrollPhysics(),
                                  padding: const EdgeInsets.all(8),
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      mainAxisExtent: 260),
                                  itemBuilder: (context, index) {
                                    UserEntity user = state.usersListRecent![index];
                                    return TopUserCard(
                                      user: user,
                                      isRecent: true,
                                    );
                                  },
                                ),
                                const SizedBox(height: 10,),
                                InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: (){
                                      showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      isDismissible: false,
                                      useSafeArea: true,
                                      builder: (BuildContext context) {
                                          return FullTopUserRecentPage(listUser: state.usersListRecent ?? []);
                                      });
                                    },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context).brightness == Brightness.light
                                          ? Colors.white : Colors.black,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
                                            offset: const Offset(0.5,1.5),
                                            blurRadius: 3
                                          )
                                        ]
                                    ),
                                    child: Text(S().topUserButtonSeeMore, style: const TextStyle(fontSize: 17),),
                                  ),
                                )

                              ],
                            )
                            : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("no_data".withImage(),width: 100,),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                S().listCardEmptyContent,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        );
                      }
                      if (state.loadDataStatus == LoadStatus.loading) {
                        return _loadingList();
                      }
                      return const SizedBox();
                    }),

                BlocBuilder<TopUserCubit, TopUserState>(
                    builder: (context, state) {
                      if (state.loadDataStatus == LoadStatus.success) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0,left: 20),
                                child: Text(S().topUserSameHobbiesTitle,
                                  style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                              ),
                            ),
                            GridView.builder(
                              itemCount: 2,
                              shrinkWrap: true,
                              addAutomaticKeepAlives: false,
                              physics: const ScrollPhysics(),
                              padding: const EdgeInsets.all(8),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 260),
                              itemBuilder: (context, index) {
                                UserEntity user = state.usersListCommonInterests![index];
                                return TopUserCard(
                                  user: user,
                                  isRecent: false,
                                );
                              },
                            ),

                            const SizedBox(height: 10,),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: (){
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    useSafeArea: true,
                                    builder: (BuildContext context) {
                                      return FullTopUserInterestPage(listUser: state.usersListCommonInterests ?? []);
                                    });

                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? Colors.white : Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade400,
                                          offset: const Offset(0.5,1.5),
                                          blurRadius: 3
                                      )
                                    ]
                                ),
                                child: Text(S().topUserButtonSeeMore, style: const TextStyle(fontSize: 17),),
                              ),
                            )

                          ],
                        );
                      }
                      if (state.loadDataStatus == LoadStatus.loading) {
                        return const SizedBox();
                      }
                      return const SizedBox();
                    }),

              ],
            ),
          )),

    );
  }
  _loadingList() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 260),
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.black12,
          highlightColor: Colors.white,
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white30),
          )),
    ),
  );

}