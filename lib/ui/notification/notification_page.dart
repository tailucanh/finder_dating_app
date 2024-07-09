import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/ui/notification/notification_detail/notification_detail_page.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../model/enums/load_state.dart';
import '../login/widgets/button_submit_page_view.dart';
import 'notification_cubit.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotificationCubit();
      },
      child: const NotificationChildPage(),
    );
  }
}

class NotificationChildPage extends StatefulWidget {
  const NotificationChildPage({super.key});

  @override
  State<NotificationChildPage> createState() => _NotificationChildPageState();
}

class _NotificationChildPageState extends State<NotificationChildPage> {
  late final NotificationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          PrimaryAppBar(context: context, text: S().notificationScreenTitle),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (previous, current) =>
          previous.loadDataStatus != current.loadDataStatus,
      builder: (context, state) {
        (state.list ?? [])
            .sort((a, b) => (b.time ?? '').compareTo(a.time ?? ''));
        return state.loadDataStatus == LoadStatus.initial
            ? Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  color: const Color(0xFFd73730),
                  size: 70,
                ),
              )
            : (state.loadDataStatus == LoadStatus.success)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                      (state.list!.isNotEmpty)
                          ? Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: state.list?.length ?? 0,
                                itemBuilder: (context, index) =>
                                    NotificationDetailPage(
                                  item: state.list?[index],
                                ),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 40,
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
                                    S().notificationScreenContent,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: ButtonSubmitPageView(
                                      text: S().textRefresh,
                                      color: Colors.transparent,
                                      onPressed: () {
                                        setState(() {});
                                      }),
                                )
                              ],
                            ),
                    ],
                  )
                : Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: const Color(0xFFd73730),
                      size: 70,
                    ),
                  );
      },
    );
  }
}
