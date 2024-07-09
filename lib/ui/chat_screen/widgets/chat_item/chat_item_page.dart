import 'package:chat_app/model/params/card_chat.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/widgets/app_cache_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/l10n.dart';
import 'chat_item_cubit.dart';

class ChatItemPage extends StatelessWidget {
  final CardChat? item;

  const ChatItemPage({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ChatItemCubit();
      },
      child: ChatItemChildPage(item: item,),
    );
  }
}

class ChatItemChildPage extends StatefulWidget {
  const ChatItemChildPage({super.key, this.item});

  final CardChat? item;

  @override
  State<ChatItemChildPage> createState() => _ChatItemChildPageState();
}

class _ChatItemChildPageState extends State<ChatItemChildPage> {
  late final ChatItemCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(id: widget.item?.idUser ?? '');
    _cubit.getActiveTime(id: widget.item?.idUser ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(AppRoutes.detailChat, queryParameters: {
        'idChat': widget.item?.idChat,
        'idUser': widget.item?.idUser,
      }),
      child: BlocBuilder<ChatItemCubit, ChatItemState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                AppCacheAvatar(
                  linkAvatar: state.userEntity?.avatar,
                  activeTime: state.tokenTime?.timeActive,
                  status: state.userEntity?.activeStatus ?? false,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.userEntity?.fullName ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        (widget.item?.lastMessage ?? '').isNotEmpty
                            ? widget.item?.lastMessage ?? ""
                            : S().messageScreenNoMessage,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 1.5,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
