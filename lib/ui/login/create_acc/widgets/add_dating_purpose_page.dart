import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/helpers/helpers_data_user.dart';
import 'package:chat_app/generated/l10n.dart';
import '../../widgets/button_submit_page_view.dart';
import '../create_acc_cubit.dart';

class AddDatingPurposePageSection extends StatefulWidget {
  final PageController pageController;
  const AddDatingPurposePageSection({super.key,required this.pageController});

  @override
  State<AddDatingPurposePageSection> createState() => _AddDatingPurposePageSectionChildPageState();
}

class _AddDatingPurposePageSectionChildPageState extends State<AddDatingPurposePageSection> {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 300) / 2;
    final double itemWidth = size.width / 2;

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
      body:  BlocBuilder<CreateAccCubit, CreateAccState>(
        buildWhen: (previous, current) => previous.datingPurpose != current.datingPurpose,
        builder: (context, state) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height / 1.16,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S().titleAddDatingPurposePage,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 28),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        S().textContentDatingPurpose,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.7,
                    margin: const EdgeInsets.only(top: 20),
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: itemWidth / itemHeight,
                      children: List.generate(HelpersDataUser.datingPurposeList().length, (index) {
                        final item = HelpersDataUser.datingPurposeList()[index];
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<CreateAccCubit>(context)
                                .changeDatingPurpose(datingPurpose: index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
                              border: Border.all(
                                color:  index == state.datingPurpose
                                    ? const Color(0xFFE94057)
                                    : Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.grey.shade900,
                                width:   index == state.datingPurpose ? 2: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  HelpersDataUser
                                      .emojiDatingPurposeList[index],
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item,
                                  style:  TextStyle(fontSize: 14.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),


                ],
              ),
            ),
          );
      },
      ),
    );
  }
}
