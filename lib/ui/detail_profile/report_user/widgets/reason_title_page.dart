import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/ui/detail_profile/report_user/report_user_cubit.dart';
import 'package:chat_app/ui/detail_profile/report_user/report_user_state.dart';
import 'package:chat_app/ui/detail_profile/report_user/widgets/compoments/item_select_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReasonTitlePage extends StatefulWidget {
  const ReasonTitlePage({super.key, required this.cubit});
  final ReportUserCubit cubit;

  @override
  State<ReasonTitlePage> createState() =>
      _ReasonTitleSectionState();
}

class _ReasonTitleSectionState extends State<ReasonTitlePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportUserCubit, ReportUserState>(
      builder: (context, state) {
        return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 130, top: 20, left: 15,right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                  Text(S().reportReasonTitle, style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                  const SizedBox(height: 10,),
                  Text(S().reportReasonContent, style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                  const SizedBox(height: 20,),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: HelpersDataUser.reportTitleList().length,
                      itemBuilder: (context, index) {
                        String item = HelpersDataUser.reportTitleList()[index];
                        return ItemReportSelect(
                            title: item,
                            state: state.reasonTitle.contains(item),
                            onTap: (){
                              widget.cubit.changeReasonTitle(reasonTitle: item);
                            }
                        );
                      }),
                  ),

              ],
            ),
          );
      },
    );
  }
}
