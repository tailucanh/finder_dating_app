import 'package:chat_app/app/app_color.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/ui/detail_profile/report_user/report_user_cubit.dart';
import 'package:chat_app/ui/detail_profile/report_user/report_user_state.dart';
import 'package:chat_app/ui/detail_profile/report_user/widgets/reason_detail_page.dart';
import 'package:chat_app/ui/detail_profile/report_user/widgets/reason_submit_page.dart';
import 'package:chat_app/ui/detail_profile/report_user/widgets/reason_title_page.dart';
import 'package:chat_app/ui/login/widgets/button_submit_page_view.dart';
import 'package:chat_app/ui/widgets/popup_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReportUserPage extends StatelessWidget {
  final String idUser;
  const ReportUserPage({
    super.key,
    required this.idUser
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ReportUserCubit();
      },
      child: ReportPageChildPage(idUser: idUser,),
    );
  }
}

class ReportPageChildPage extends StatefulWidget {
  const ReportPageChildPage({super.key,required this.idUser});

  final String idUser;
  @override
  State<ReportPageChildPage> createState() => _ReportPageChildPageState();
}

class _ReportPageChildPageState extends State<ReportPageChildPage> {
  late final ReportUserCubit _cubit;
  late final PageController pageController;
  final time = const Duration(milliseconds: 200);
  final reportContent = TextEditingController();



  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
    );
    _cubit = BlocProvider.of(context);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pageController.page! > 0) {
          pageController.previousPage(
              duration: time, curve: Curves.bounceInOut);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          height: 150,
          elevation: 2,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade300 : AppColors.black700,
          child: BlocBuilder<ReportUserCubit, ReportUserState>(
            buildWhen: (previous, current) {
              return previous.reportStatus != current.reportStatus ||  previous.indexPage != current.indexPage;
            },
          builder: (context, state) {
            return Padding(
            padding: const EdgeInsets.only(top:10,bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(S().reportReasonButtonContent, style: TextStyle(fontSize: 10),),
                const SizedBox(height: 8,),
                ButtonSubmitPageView(
                    text: state.indexPage != 2 ? S().reportReasonButtonNext : S().reportReasonButtonSend,
                    color: state.reportStatus == LoadStatus.success ? Colors.transparent
                             : Colors.grey ,
                    onPressed: ()  {
                        if(state.indexPage == 0 && state.reasonTitle.isNotEmpty){
                          pageController.nextPage(
                              duration: time, curve: Curves.bounceInOut);
                          _cubit.changeStatusPage();
                        }
                        if(state.indexPage == 1 ){
                          pageController.nextPage(
                              duration: time, curve: Curves.bounceInOut);
                          _cubit.changeStatusPage();
                        }
                        if(state.indexPage == 2){
                          _cubit.reportUser(idUser: widget.idUser,reasonTitle: state.reasonTitle,
                              reasonDetail: state.reasonDetail, content: reportContent.text ?? '');
                          AppPopupNotification.showDialogComplete(context,
                              content: S().reportReasonDialogContent, onSubmit:() {
                              context.pop();
                              Navigator.of(context).pop();
                              });

                      }
                    })
              ],
            ),
          );
          },
        ),
        ),
        body: SafeArea(
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                        child: SizedBox()),
                    Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.shield, color: Colors.blueAccent, size: 45,),
                        )),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(S().textCancelDialogLocation, style: TextStyle(color: Colors.blueAccent,fontSize: 17,
                            fontWeight: FontWeight.w500),textAlign: TextAlign.right,),
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<ReportUserCubit, ReportUserState>(
                buildWhen: (previous, current) {
                  return previous.indexPage != current.indexPage;
                },
                builder: (context, state) {
                    return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Ink(
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: state.indexPage == 0 ? AppColors.primaryColor :
                                                Theme.of(context).brightness == Brightness.light
                                                ? Colors.grey.shade400 : Colors.grey.shade600,
                                          ),
                                        ),
                                        Text(S().reportReasonTab_1,style: TextStyle(
                                            color:state.indexPage == 0 ? Theme.of(context).brightness == Brightness.light
                                                ? Colors.black : Colors.white : Colors.grey.shade400 ,
                                            fontSize: 13,fontWeight: FontWeight.w500),)

                                      ],
                                    )),
                                const SizedBox(width: 8,),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Ink(
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: state.indexPage == 1 ? AppColors.primaryColor :
                                            Theme.of(context).brightness == Brightness.light
                                                ? Colors.grey.shade400 : Colors.grey.shade600,
                                          ),
                                        ),
                                        Text(S().reportReasonTab_2,style: TextStyle(
                                            color:state.indexPage == 1 ? Theme.of(context).brightness == Brightness.light
                                                ? Colors.black : Colors.white : Colors.grey.shade400 ,
                                            fontSize: 13,fontWeight: FontWeight.w500),)

                                      ],
                                    )),
                                const SizedBox(width: 8,),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Ink(
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: state.indexPage == 2 ? AppColors.primaryColor :
                                            Theme.of(context).brightness == Brightness.light
                                                ? Colors.grey.shade400 : Colors.grey.shade600,
                                          ),
                                        ),
                                        Text(S().reportReasonTab_3,style: TextStyle(
                                            color:state.indexPage == 2 ? Theme.of(context).brightness == Brightness.light
                                                ? Colors.black : Colors.white : Colors.grey.shade400 ,
                                            fontSize: 13,fontWeight: FontWeight.w500),)

                                      ],
                                    )),
                              ],
                            );
                },
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) async =>
                  await _cubit.changePage(indexPage: value),
                  children: [
                      ReasonTitlePage(cubit: _cubit),
                      ReasonDetailPage(cubit: _cubit),
                      ReasonSubmitPage(cubit: _cubit, reportContent:  reportContent)

                  ],
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),

    );
  }



  @override
  void dispose() {
    _cubit.close();
    pageController.dispose();
    reportContent.dispose();
    super.dispose();
  }
}
