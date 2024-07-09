import 'package:chat_app/ui/login/create_acc/create_acc_cubit.dart';
import 'package:chat_app/ui/login/widgets/custom_item_create_infomation.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/button_submit_page_view.dart';

class AddRequestToShowPageSection extends StatefulWidget {
  final PageController pageController;
  const AddRequestToShowPageSection({super.key, required this.pageController});

  @override
  State<AddRequestToShowPageSection> createState() =>
      _AddRequestToShowPageSectionChildPageState();
}

class _AddRequestToShowPageSectionChildPageState
    extends State<AddRequestToShowPageSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: ButtonSubmitPageView(
            text: S().textNextButton,
            color: Colors.transparent,
            onPressed: () {
              widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear);
            }),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: BlocBuilder<CreateAccCubit, CreateAccState>(
            buildWhen: (previous, current) =>
                previous.requestGender != current.requestGender,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S().titleAddRequestToShow,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 28),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ItemInformation(
                    title: S().gender_male,
                    state: state.requestGender == 0,
                    onTap: () => BlocProvider.of<CreateAccCubit>(context)
                        .changeRequest(request: 0),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ItemInformation(
                      title: S().gender_female,
                      state: state.requestGender == 1,
                      onTap: () => BlocProvider.of<CreateAccCubit>(context)
                          .changeRequest(request: 1)),
                  SizedBox(
                    height: 10.h,
                  ),
                  ItemInformation(
                      title: S().gender_other,
                      state: state.requestGender == 2,
                      onTap: () => BlocProvider.of<CreateAccCubit>(context)
                          .changeRequest(request: 2)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
