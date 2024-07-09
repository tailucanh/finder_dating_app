import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/model/params/card_chat.dart';
import 'package:chat_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'chat_search_item_cubit.dart';

class ChatSearchItemPage extends StatelessWidget {
  final CardChat? item;

  const ChatSearchItemPage({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ChatSearchItemCubit();
      },
      child: ChatItemChildPage(item: item),
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
  late final ChatSearchItemCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(id: widget.item?.idUser ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(AppRoutes.detailChat, queryParameters: {
        'idChat': widget.item?.idChat,
        'idUser': widget.item?.idUser,
      }),
      child: BlocBuilder<ChatSearchItemCubit, ChatSearchItemState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                _buildUserAvatar(state.userEntity?.avatar ?? "",

                    state.userEntity?.activeStatus ?? false
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    state.userEntity?.fullName ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserAvatar(String avatar, bool online) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        shape: BoxShape.circle
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: CachedNetworkImage(
              width: 40.w,
              height: 40.h,
              imageUrl: avatar,
              key: UniqueKey(),
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => Center(
                child: Icon(
                  Icons.person_outline_rounded,
                  color: Colors.red,
                  size: 30.sp,
                ),
              ),
            ),
          ),
          online
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                    ),
                  ))
              : const SizedBox(),
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
