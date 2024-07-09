import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/config/extentions/String_ext.dart';
import 'package:chat_app/ui/widgets/popup_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/helpers/helpers_data_user.dart';
import '../../generated/l10n.dart';
import 'on_boarding_cubit.dart';
import 'on_boarding_navigator.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return OnBoardingCubit(
          navigator: OnBoardingNavigator(context: context),
        );
      },
      child: const OnBoardingChildPage(),
    );
  }
}


class OnBoardingChildPage extends StatefulWidget {
  const OnBoardingChildPage({super.key});

  @override
  State<OnBoardingChildPage> createState() => _OnBoardingChildPageState();
}

class _OnBoardingChildPageState extends State<OnBoardingChildPage> {
  late final OnBoardingCubit _cubit;
  late double buttonOffset = 0.0;

  List<String> images = [
    'avatar1'.withIconPNG(),
    'avatar2'.withIconPNG(),
    'avatar3'.withIconPNG(),
  ];



  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWith = MediaQuery.of(context).size.width - 65;

    return WillPopScope(
      onWillPop: () async {
        AppPopupNotification.dialogExitApp(context: context,content: S.current.contentDialogExitApp, onExit: ()=> SystemNavigator.pop());
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          height: 90,
          child: GestureDetector(
            onPanUpdate: (details){
              if(details.delta.dx > 0 && buttonOffset  <= buttonWith - 65){
                setState(() {
                  buttonOffset += details.delta.dx;
                });
              }
            },
            onPanEnd: (_)  {
              if(buttonOffset > buttonWith / 2){
                setState(() {
                  buttonOffset = buttonWith;
                });
                _cubit.openPage();
              }else {
                setState(() {
                  buttonOffset = 0.0;
                });
              }
            },
            child: Container(
                width: buttonWith,
                decoration: BoxDecoration(
                  color: Colors.red.shade200.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(S.current.titleButtonOnBoarding,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      width: buttonOffset + 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color:  Colors.red.shade300.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      duration: const Duration(milliseconds: 200),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 65,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE94057),
                            shape: BoxShape.circle
                          ),
                          child: const Center(
                            child: Icon(Icons.chevron_right_rounded,size: 40,color: Colors.white,),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
          )
        ),
        body: SafeArea(
          child: _buildBodyWidget(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
        builder: (context, onBoarding) => SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: CarouselSlider(
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 2.3,
                            autoPlay: true,
                            // Tự động chuyển đổi giữa các phần tử
                            enlargeCenterPage: true,
                            // Phóng to phần tử nằm ở giữa
                            viewportFraction: 0.6,
                            // Tỷ lệ chiếm màn hình của phần tử
                            onPageChanged: (index, reason) {
                              context
                                  .read<OnBoardingCubit>()
                                  .onChangeIndex(index);
                            }),
                        items: List.generate(3, (index) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(images[index]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          );
                        })),
                  ),
                  Text(
                    HelpersDataUser.listOnBoardingTitle()
                        .elementAt(onBoarding.index),
                    style: const TextStyle(
                        color: Color.fromRGBO(233, 64, 87, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          left: 25, right: 25,top: 10,bottom: 30),
                      child: Text(
                        HelpersDataUser.listOnBoardingContent()
                            .elementAt(onBoarding.index),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(3, (i) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: onBoarding.index == i
                              ? const Color.fromRGBO(233, 64, 87, 1)
                              : Colors.grey.shade200,
                        ),
                      );
                    }),
                  ),

                ],
              ),
            ));
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
