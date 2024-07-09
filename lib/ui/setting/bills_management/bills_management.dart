import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/ui/login/widgets/button_submit_page_view.dart';
import 'package:chat_app/ui/setting/bills_management/bills_management_cubit.dart';
import 'package:chat_app/ui/setting/bills_management/widgets/bill_item.dart';
import 'package:chat_app/ui/setting/bills_management/widgets/full_bill_page.dart';
import 'package:chat_app/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BillsManagement extends StatelessWidget {
  const BillsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BillsManagementCubit(),
      child: const BillsManagementChild(),
    );
  }
}

class BillsManagementChild extends StatefulWidget {
  const BillsManagementChild({super.key});

  @override
  State<BillsManagementChild> createState() => _BillsManagementChildState();
}

class _BillsManagementChildState extends State<BillsManagementChild> {
  late BillsManagementCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<BillsManagementCubit>(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PrimaryAppBar(context: context, text: S.current.billManagementTitle),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade100
          : AppColors.black700,
      body: BlocBuilder<BillsManagementCubit, BillsManagementState>(
          builder: (context, state) {
        if (state.loadStatus == LoadStatus.loading) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: const Color(0xFFd73730),
              size: 70,
            ),
          );
        } else if (state.loadStatus == LoadStatus.success) {
          return state.billsList!.isNotEmpty
              ? ListView.separated(
                  itemCount: state.billsList!.length,
                  itemBuilder: (context, index) {
                    final bill = state.billsList![index];
                    return BillItem(billItem: bill, onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          isDismissible: false,
                          useSafeArea: true,
                          builder: (BuildContext context) {
                            return FullBillPage(payEntity: bill, user: state.user!,);
                          });
                    },);
                  },
                  separatorBuilder: (context, index) => const SizedBox(),
                )
              :  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "no_data".withImage(),
                width: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  S().billEmptyData,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: ButtonSubmitPageView(
                    text: S().billPayButtonTittle,
                    color: Colors.transparent,
                    onPressed: () async {
                      context.goNamed(AppRoutes.payment);
                    }),
              )
            ],
          );
        }

        return const Center(
          child: Text("Can load data"),
        );
      }),
    ));
  }
}
