import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/generated/l10n.dart';
import '../../widgets/button_submit_page_view.dart';

class RulesPageSection extends StatelessWidget {
  final PageController pageController;
  const RulesPageSection({super.key, required this.pageController});

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
          onPressed: () => pageController.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.linear)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'ic_tinder_logo'.withImage(),
                    width: 40,
                  ),
                  Expanded(
                    child: Text(
                      S().titleRulersPage,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.sp),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                S().contentRules,
                style: TextStyle(fontSize: 15.sp),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                S().contentRule1,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                S().contentRule1_1,
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                S().contentRule2,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
              ),
              SizedBox(
                height: 8.h,
              ),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: S().contentRule2_1,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                    fontSize: 14.sp,
                  ),
                  children: <TextSpan>[

                    TextSpan(
                      text: S().contentRule2_2,
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                S().contentRule3,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                S().contentRule3_1,
                style: TextStyle(fontSize: 14.sp),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                S().contentRule4,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                S().contentRule4_1,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
