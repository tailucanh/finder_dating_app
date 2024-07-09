import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/payment/payment_navigater.dart';
import 'package:chat_app/ui/widgets/popup_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../generated/l10n.dart';
import 'payment_cubit.dart';
import 'widgets/indicator_highlight_page.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PaymentCubit(navigator: PaymentNavigator(context: context));
      },
      child: const PaymentChildPage(),
    );
  }
}

class PaymentChildPage extends StatefulWidget {
  const PaymentChildPage({super.key});

  @override
  State<PaymentChildPage> createState() => _PaymentChildPageState();
}

class _PaymentChildPageState extends State<PaymentChildPage> {
  late final PaymentCubit _cubit;

  int _selectedIndex = 0;
  List<int> priorityList = [1, 2, 3];

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
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
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => context.pop('refreshVip'),
                  child: SvgPicture.asset(
                    'delete'.withIcon(),
                    width: 20,
                    colorFilter:
                        const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  ),
                ),
              ),
              Text(
                S().highlightPageTitle,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                S().highlightPageContent,
                style: const TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 250,
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.76),
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: HelpersDataUser.highlightPriceList.length,
                    itemBuilder: (context, index) {
                      var scale = _selectedIndex == index ? 1.0 : 0.8;

                      return TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 350),
                        tween: Tween(begin: scale, end: scale),
                        curve: Curves.ease,
                        child: buildItemPageView(
                            _cubit,
                            state.isPrimaryAcceleration,
                            HelpersDataUser.highlightAppbarTitleList()[index]
                                .toUpperCase(),
                            HelpersDataUser.highlightTitleTimeList()[index]
                                .toUpperCase(),
                            HelpersDataUser.highlightPriceList[index],
                            HelpersDataUser.highlightCountList[index],
                            priorityList[index]),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                      );
                    }),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                      HelpersDataUser.highlightPriceList.length,
                      (index) => Indicator(
                          isActive: _selectedIndex == index ? true : false)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildItemPageView(PaymentCubit cubit, bool isPrimaryAcceleration,
      String titleAppBar, String title, String price, int count, int priority) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade300
                : Colors.grey.shade800,
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titleAppBar.isNotEmpty
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(251, 233, 255, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Text(titleAppBar ?? '',
                      style: const TextStyle(
                          color: Color.fromRGBO(178, 27, 240, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                )
              : const SizedBox(),
          const SizedBox(
            height: 15,
          ),
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 10,
          ),
          Text('$price \$/M',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 35,
          ),
          InkWell(
            onTap: () {
              (!isPrimaryAcceleration)
                  ? _cubit.setPaymentInfo(price: double.parse(price.toString()), turn: count, priority: priority).whenComplete(() =>  context.goNamed(AppRoutes.paymentMethods, extra: _cubit))
                  : AppPopupNotification.showDialogComplete(context,
                      content: S().highlightNotificationText,onSubmit: () => Navigator.of(context).pop());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(180, 47, 248, 1),
                    Color.fromRGBO(236, 119, 249, 1)
                  ],
                ),
              ),
              child: Text(
                S().highlightButtonText,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
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
