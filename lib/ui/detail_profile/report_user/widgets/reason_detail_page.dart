import 'package:chat_app/config/helpers/helpers_data_user.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/ui/detail_profile/report_user/report_user_cubit.dart';
import 'package:chat_app/ui/detail_profile/report_user/report_user_state.dart';
import 'package:chat_app/ui/detail_profile/report_user/widgets/compoments/item_select_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReasonDetailPage extends StatefulWidget {
  const ReasonDetailPage({super.key, required this.cubit});
  final ReportUserCubit cubit;

  @override
  State<ReasonDetailPage> createState() =>
      _ReasonDetailSectionState();
}

class _ReasonDetailSectionState extends State<ReasonDetailPage> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportUserCubit, ReportUserState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 130, top: 20, left: 15,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(child: Text(S().reportDetailReasonTitle, style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)),
              const SizedBox(height: 20,),
              Text(S().reportDetailReason_1, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
              const SizedBox(height: 10,),
              SizedBox(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: HelpersDataUser.reportTitleDetailList_1().length,
                    itemBuilder: (context, index) {
                      String item = HelpersDataUser.reportTitleDetailList_1()[index];
                      return ItemReportSelect(
                          title: item,
                          state: state.reasonDetail.contains(item),
                          onTap: (){
                            widget.cubit.changeReasonDetail(reasonDetail: item);
                          }
                      );
                    }),
              ),
              const SizedBox(height: 10,),
              Text(S().reportDetailReason_2, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
              const SizedBox(height: 10,),
              SizedBox(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: HelpersDataUser.reportTitleDetailList_2().length,
                    itemBuilder: (context, index) {
                      String item = HelpersDataUser.reportTitleDetailList_2()[index];
                      return ItemReportSelect(
                          title: item,
                          state: state.reasonDetail.contains(item),
                          onTap: (){
                            widget.cubit.changeReasonDetail(reasonDetail: item);
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
