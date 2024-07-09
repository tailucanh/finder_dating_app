import 'package:flutter/material.dart';

import 'package:chat_app/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/helpers/helpers_data_user.dart';
import '../../widgets/button_submit_page_view.dart';
import '../create_acc_cubit.dart';

class AddInterestsListPageSection extends StatefulWidget {
  final PageController pageController;
  const AddInterestsListPageSection({super.key, required this.pageController});

  @override
  State<AddInterestsListPageSection> createState() =>
      _AddInterestsListPageSectionChildPageState();
}

class _AddInterestsListPageSectionChildPageState
    extends State<AddInterestsListPageSection> {
  List<int> selectInterests = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccCubit, CreateAccState>(
      builder: (context, state) {
        if (state.interests != null) {
          selectInterests = state.interests ?? [];
        }
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            child: ButtonSubmitPageView(
                text: '${S().textNextButton}  ${selectInterests.length}/5',
                color: (selectInterests.length >= 5)
                    ? Colors.transparent
                    : Colors.grey,
                onPressed: () {
                  if (selectInterests.length >= 5) {
                    BlocProvider.of<CreateAccCubit>(context)
                        .changeInterests(interests: selectInterests);
                    widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.linear);
                  }
                }),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height / 1.16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S().titleAddInterestsPage,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 25.sp),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      S().textContentInterests,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.65,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Wrap(
                      children: List.generate(
                        HelpersDataUser.interestsList().length,
                        (index) {
                          final item = HelpersDataUser.interestsList(
                              )[index];
                          final isSelected =
                              HelpersDataUser.getItemFromListIndex(
                                      HelpersDataUser.interestsList(),
                                      selectInterests)
                                  .contains(item);
                          return InkWell(
                            onTap: () {
                              setState(() {
                                (selectInterests.length < 5)
                                    ? !isSelected
                                        ? selectInterests.add(index)
                                        : selectInterests.remove(index)
                                    : isSelected
                                        ? selectInterests.remove(index)
                                        : null;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, right: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width: isSelected ? 2 : 1,
                                    color: isSelected
                                        ? const Color.fromRGBO(
                                            234,
                                            64,
                                            128,
                                            1,
                                          )
                                        : Colors.grey,
                                  ),
                                ),
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
