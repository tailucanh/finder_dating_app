import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/ui/top_and_like_user/who_love/widgets/liked_user_card/liked_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../config/helpers/helpers_data_user.dart';
import '../../../model/package_binder_model.dart';
import '../../widgets/popup_notification.dart';
import 'who_love_cubit.dart';
import 'who_love_navigator.dart';

class WhoLovePage extends StatelessWidget {
  const WhoLovePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return WhoLoveCubit(
          navigator: WhoLoveNavigator(context: context),
        );
      },
      child: const WhoLoveChildPage(),
    );
  }
}

class WhoLoveChildPage extends StatefulWidget {
  const WhoLoveChildPage({super.key});

  @override
  State<WhoLoveChildPage> createState() => _WhoLoveChildPageState();
}

class _WhoLoveChildPageState extends State<WhoLoveChildPage> {
  late final WhoLoveCubit _cubit;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    _scrollController.addListener(() => _scrollListener(context));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cubit.close();
  }


  void _scrollListener(BuildContext context) {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&  !(context.read<WhoLoveCubit>().state.isPrimaryGold)) {
       HelpersDataUser.packageVip(index: 2,context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {

    return BlocBuilder<WhoLoveCubit, WhoLoveState>(
        builder: (context, state) {
      if (state.loadDataStatus == LoadStatus.success) {
        return (state.userFollowers ?? []).isNotEmpty
            ? Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 20, left: 20, right: 20),
                          child: Text(
                            state.isPrimaryGold
                                ? S().whoLikePageContent
                                : S().whoLikePageContentGold,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        GridView.builder(
                          itemCount: state.userFollowers!.length,
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
                            UserEntity user = state.userFollowers![index];
                            return LikedUserCard(
                              user: user,
                              isUserGold: state.isPrimaryGold,
                            );
                          },
                        ),
                      ],
                    ),
                ),
                state.isPrimaryGold
                    ? const SizedBox()
                    : Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () =>   HelpersDataUser.packageVip(index: 2,context: context),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width - 80,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(247, 151, 30, 1.0),
                              Color.fromRGBO(255, 210, 0, 1.0)
                            ],
                          ),
                        ),
                        child: Text(
                          S().whoLikePageButtonGold,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ))

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
      return Container();
    });
  }

  _loadingList() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 260),
        itemCount: 6,
        shrinkWrap: true,
        itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: Colors.white,
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 2,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white30),
            )),
      );

}
