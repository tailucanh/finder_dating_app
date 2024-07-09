
import 'package:chat_app/model/enums/load_state.dart';
import 'package:equatable/equatable.dart';

class ReportUserState extends Equatable {
  final LoadStatus reportStatus;
  final int indexPage;
  final String content;
  final String reasonTitle;
  final String reasonDetail;

  const ReportUserState(
      {this.reportStatus = LoadStatus.initial,
        this.indexPage = 0,
        this.reasonTitle = '',
        this.reasonDetail = '',
        this.content = '',
     });

  @override
  List<Object?> get props => [
    reportStatus,
        indexPage,
        reasonTitle,
        reasonDetail,
        content,
      ];

  ReportUserState copyWith(
      {LoadStatus? reportStatus,
         int? indexPage,
         String? content,
         String? reasonTitle,
         String? reasonDetail,
   }) {
    return ReportUserState(
        reportStatus: reportStatus ?? this.reportStatus,
          indexPage: indexPage ?? this.indexPage,
         content: content ?? this.content,
        reasonTitle: reasonTitle ?? this.reasonTitle,
        reasonDetail: reasonDetail ?? this.reasonDetail,

        );
  }
}
