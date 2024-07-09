import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/ui/chat_search/widgets/chat_item/chat_search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'chat_search_cubit.dart';
import 'chat_search_navigator.dart';

class ChatSearchPage extends StatelessWidget {
  const ChatSearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ChatSearchCubit(
          navigator: ChatSearchNavigator(context: context),
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
  late final ChatSearchCubit _cubit;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    focusNode.requestFocus();
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back)),
                SizedBox(
                  width: 10.h,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) async {
                      await _cubit.search(value);
                    },
                    focusNode: focusNode,
                    style: TextStyle(color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black : Colors.white,fontSize: 19.sp,fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: S.current.searchInputHint,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],

            ),
            BlocBuilder<ChatSearchCubit, ChatSearchState>(
              builder: (context, state) {
                if (state.loadDataStatus == LoadStatus.success) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.listChat!.length,
                    itemBuilder: (context, index) {
                      return ChatSearchItemPage(
                        item: state.listChat?[index],
                      );
                    },
                  );
                }
                if (state.loadDataStatus == LoadStatus.loading) {
                  return _loadingList();
                }

                return const Center(
                  child: Text("Can't find user"),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _loadingList() => ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.black12,
            highlightColor: Colors.white,
            child: Container(
              height: 80.h,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white30),
            )),
      );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
