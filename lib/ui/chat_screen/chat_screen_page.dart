import 'dart:math';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/model/params/card_chat.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/chat_screen/widgets/chat_item/chat_item_page.dart';
import 'package:chat_app/ui/chat_screen/widgets/story_card.dart';
import 'package:chat_app/ui/chat_screen/widgets/story_detail.dart';
import 'package:chat_app/ui/main/main_cubit.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../services/call_video_service.dart';
import 'chat_screen_cubit.dart';
import 'chat_screen_navigator.dart';

class ChatScreenPage extends StatelessWidget {
  const ChatScreenPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ChatScreenCubit(
          navigator: ChatScreenNavigator(context: context),
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
  late final ChatScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    _cubit.loadStory();
    onUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        context: context,
        actionsWidget: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shield_rounded,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                context.pushNamed(AppRoutes.searchChat).then((value) =>
                    BlocProvider.of<MainCubit>(context).switchTap(3));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                  decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 40,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                      ),

                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15),
                      enabled: false,
                      hintText: S.current.searchInputHint,
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 15),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.grey
                                    : Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(100))),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 160.h,
              child: BlocBuilder<ChatScreenCubit, ChatScreenState>(
                buildWhen: (previous, current) =>
                    previous.loadStatusStory != current.loadStatusStory,
                builder: (context, state) {
                  print('listStory${(state.listStory?.length)}');
                  return state.loadStatusStory == LoadStatus.loading
                      ? _loadingListStory()
                      : Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  key: const Key('ListView1'),
                                  shrinkWrap: true,
                                  itemCount: (state.listStory ?? []).length + 1,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return InkWell(
                                        onTap: () async {
                                          await _cubit.pickVideo();
                                        },
                                        child: Container(
                                          height: 160.h,
                                          width: 110.w,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color.fromRGBO(
                                                      238, 128, 95, 1),
                                                  Color.fromRGBO(
                                                      236, 149, 123, 1),
                                                  Color.fromRGBO(
                                                      234, 64, 128, 1),
                                                  Color.fromRGBO(
                                                      232, 98, 148, 1),
                                                ],
                                                transform:
                                                    GradientRotation(pi / 4),
                                              )),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.pages,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                S().addStoryTitle,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      final itemIndex = index - 1;
                                      return StoryCardView(
                                        model: state.listStory?[itemIndex],
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            fullscreenDialog: true,
                                            builder: (context) => StoryDetail(
                                              storyList: state
                                                  .listStory?[itemIndex]
                                                  .listStory,
                                              name: state
                                                  .listStory?[itemIndex].name,
                                              avatar: state
                                                  .listStory?[itemIndex].avatar,
                                              activeStatus: state
                                                  .listStory?[itemIndex]
                                                  .activeStatus,
                                            ),
                                          ));
                                        },
                                      );
                                    }
                                  }),
                            ),
                          ],
                        );
                },
              ),
            ),
            _buildChatList(),
          ]),
    );
  }

  Widget _buildChatList() {
    return BlocConsumer<ChatScreenCubit, ChatScreenState>(
      listener: (context, state) {},
      bloc: _cubit,
      builder: (context, state) {
        return state.loadDataStatus != LoadStatus.success
            ? _loadingList()
            : StreamBuilder<List<CardChat>?>(
                stream: state.listChat,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return (snapshot.data ?? []).isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15),
                            child: ListView.builder(
                                key: const Key('ListView2'),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ChatItemPage(
                                    item: snapshot.data?[index],
                                  );
                                }),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Image.asset(
                                "no_data".withImage(),
                                width: 100,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  S().messageScreenNoMessage,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          );
                  } else {
                    return _loadingList();
                  }
                });
      },
    );
  }

  _loadingList({Axis view = Axis.vertical}) => ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: Colors.white,
            child: Container(
              height: view == Axis.horizontal ? 150.h : 80.h,
              width: view == Axis.horizontal
                  ? 100.w
                  : MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white30),
            )),
      );

  _loadingListStory() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 260),
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.black12,
              highlightColor: Colors.white,
              child: Container(
                height: 160,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white30),
              )),
        ),
      );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
