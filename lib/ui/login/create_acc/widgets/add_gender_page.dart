import 'package:chat_app/ui/login/create_acc/create_acc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/generated/l10n.dart';
import '../../widgets/button_submit_page_view.dart';
import '../../widgets/custom_item_create_infomation.dart';

class AddGenderPageSection extends StatefulWidget {

  final Function()? callBack;
  final PageController pageController;
  const AddGenderPageSection({super.key,required this.pageController, this.callBack});


  @override
  State<AddGenderPageSection> createState() => _AddGenderPageSectionChildPageState();
}

class _AddGenderPageSectionChildPageState extends State<AddGenderPageSection> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: ButtonSubmitPageView(
            text:  S().textNextButton,
            color: Colors.transparent,
            onPressed: () {
               widget.pageController.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.linear);
            }),
      ),
      body: BlocBuilder<CreateAccCubit, CreateAccState>(
        buildWhen: (previous, current) => previous.gender != current.gender,
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S().titleAddGender,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ItemInformation(
                    title: S().gender_male,
                    state: state.gender == 0,
                    onTap: () => BlocProvider.of<CreateAccCubit>(context)
                        .changeGender(gender: 0),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ItemInformation(
                      title: S().gender_female,
                      state: state.gender == 1,
                      onTap: () => BlocProvider.of<CreateAccCubit>(context)
                          .changeGender(gender: 1)),
                  SizedBox(
                    height: 10.h,
                  ),
                  ItemInformation(
                      title: S().gender_other,
                      state: state.gender == 2,
                      onTap: () => BlocProvider.of<CreateAccCubit>(context)
                          .changeGender(gender: 2)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
