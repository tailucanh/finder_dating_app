import 'package:json_annotation/json_annotation.dart';
part 'report.g.dart';

@JsonSerializable()
class Report {
  String? idUser;
  String? idUserReport;
  int? createAt;
  String? reasonTitle;
  String? reasonDetail;
  String? content;

  Report({this.idUser, this.idUserReport, this.createAt, this.reasonTitle, this.reasonDetail, this.content});

  Map<String, dynamic> toJson() => _$ReportToJson(this);

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
//
}
