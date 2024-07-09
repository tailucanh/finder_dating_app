import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/generated/l10n.dart';

import '../../widgets/button_submit_page_view.dart';
import '../create_acc_cubit.dart';

class AddNamePageSection extends StatefulWidget {
  final TextEditingController textController;
  final PageController pageController;
  const AddNamePageSection(
      {super.key, required this.pageController, required this.textController});

  @override
  State<AddNamePageSection> createState() =>
      _AddNamePageSectionChildPageState();
}

class _AddNamePageSectionChildPageState extends State<AddNamePageSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: ButtonSubmitPageView(
            text: S().textNextButton,
            color: widget.textController.text.isEmpty
                ? Colors.grey
                : Colors.transparent,
            onPressed: () {
              if (widget.textController.text.isNotEmpty) {
                BlocProvider.of<CreateAccCubit>(context)
                    .changeName(name: widget.textController.text);
                widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.linear);
              }
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                S().titleAddNamePage,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: widget.textController,
                keyboardType: TextInputType.text,
                cursorColor: const Color.fromRGBO(
                  234,
                  64,
                  128,
                  1,
                ),
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.sp),
                  constraints: BoxConstraints(
                    maxHeight: 40.sp,
                  ),
                  hintText: S().textHintEnterName,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18.sp),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(234, 64, 128, 1), width: 2),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    widget.textController.text = value;
                    BlocProvider.of<CreateAccCubit>(context)
                        .changeName(name: value);
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                S().textNotificationNamePage,
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade600
                        : Colors.grey.shade200,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
