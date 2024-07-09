import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/model/params/notification_item.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/widgets/popup_notification.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../generated/l10n.dart';
import '../../chat_screen/widgets/chat_item/widgets/custom_widget.dart';
import 'notification_detail_cubit.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationItem? item;

  const NotificationDetailPage({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotificationDetailCubit();
      },
      child: NotificationDetailChildPage(item: item),
    );
  }
}

class NotificationDetailChildPage extends StatefulWidget {
  final NotificationItem? item;

  const NotificationDetailChildPage({super.key, this.item});

  @override
  State<NotificationDetailChildPage> createState() =>
      _NotificationDetailChildPageState();
}

class _NotificationDetailChildPageState
    extends State<NotificationDetailChildPage> {
  late final NotificationDetailCubit _cubit;
  late ConfettiController _confettiController;
  late TextEditingController textMatchController;
  String date = "";
  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(id: widget.item?.id);
    textMatchController = TextEditingController();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    (widget.item?.time ?? '').isNotEmpty
        ? date = HelpersDataUser.formatMillisecondsSinceEpoch(
            widget.item?.time ?? '')
        : date = "";
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<NotificationDetailCubit, NotificationDetailState>(
      buildWhen: (previous, current) =>
          previous.loadDataStatus != current.loadDataStatus,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: widget.item?.type != "admin"
                ? widget.item?.status == 'false'
                    ? Theme.of(context).brightness == Brightness.light
                        ? Colors.white54
                        : Colors.black54
                    : Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black
                : Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade200
                    : Colors.grey.shade900,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: widget.item?.type != "admin"
                          ? CachedNetworkImage(
                              width: 45,
                              height: 45,
                              imageUrl: state.userEntity?.avatar ?? "",
                              key: UniqueKey(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            )
                          : Center(
                              child: Image.asset(
                              "ic_tinder_logo".withImage(),
                              width: 40,
                              fit: BoxFit.cover,
                            )),
                    ),
                    ((state.userEntity?.activeStatus ?? false) &&
                            widget.item?.type != "admin")
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
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item?.type != "admin"
                          ? widget.item?.type == "match"
                              ? S().compatibleContent
                              : "${state.userEntity?.fullName} ${S().sentMessageNotification} ${widget.item?.message}"
                          : '${widget.item?.message}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      HelpersDataUser.processDateTime(date),
                      style: const TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    widget.item?.type != "admin"
                        ? ButtonNotification(
                            title: widget.item?.type == 'chat'
                                ? S().feedbackText
                                : S().seenText,
                            onPressed: () {
                              if(widget.item?.type == 'chat'){
                                context.goNamed(AppRoutes.detailChat, queryParameters: {
                                  'idChat': state.chatItem?.id,
                                  'idUser': state.userEntity?.uid,
                                });
                              }else if(widget.item?.type == 'match'){
                                AppPopupNotification.showMatchDialog(context,
                                    user: state.userEntity!,
                                    textMatchController: textMatchController,
                                    controller: _confettiController);
                              }
                              _cubit.updateStatusNotification(
                                id: widget.item?.id ?? '',
                                time: widget.item?.time ?? '',
                                status: "true");
                              },
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              widget.item?.type != "admin"
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Icon(
                        Icons.camera,
                        size: 15,
                        color: widget.item?.status == 'false'
                            ? Colors.red
                            : Colors.grey.shade400,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
