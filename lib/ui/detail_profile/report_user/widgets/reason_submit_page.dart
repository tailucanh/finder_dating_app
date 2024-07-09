import 'package:chat_app/ui/detail_profile/report_user/report_user_cubit.dart';
import 'package:chat_app/ui/detail_profile/report_user/report_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';

class ReasonSubmitPage extends StatefulWidget {
  const ReasonSubmitPage({super.key, required this.cubit, required this.reportContent});
  final ReportUserCubit cubit;
  final TextEditingController reportContent;
  @override
  State<ReasonSubmitPage> createState() =>
      _ReasonSubmitPageState();
}

class _ReasonSubmitPageState extends State<ReasonSubmitPage> {




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportUserCubit, ReportUserState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 130, top: 20, left: 15,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(S().reportConfirmReasonTitle, style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              )),
              const SizedBox(height: 15,),
              Text(S().reportConfirmReasonCommentTitle, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
              const SizedBox(height: 10,),
              SizedBox(
                child: TextField(
                  controller: widget.reportContent,
                  keyboardType: TextInputType.text,
                  style: TextStyle( color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black : Colors.white, fontWeight: FontWeight.w500,fontSize: 16),
                  decoration: InputDecoration(
                      constraints: BoxConstraints(
                        minHeight: 150,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      hintText:S().reportConfirmReasonCommentHint,
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                      focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).brightness == Brightness.light
                                ? Colors.grey : Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).brightness == Brightness.light
                                ? Colors.grey : Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(8)
                      )
                  ),
                  onChanged: (value){
                      widget.cubit.changeContent(content: value);
                  },
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
