import 'package:json_annotation/json_annotation.dart';
part 'accelerate.g.dart';

@JsonSerializable()
class Accelerate {
  final int? turn;
  final String? priority;
  final String? uid;
  final String? createAt;
  final String? endAt;
  final String? timeStart;
  final String? timeEnd;

  factory Accelerate.fromJson(Map<String, dynamic> json) =>
      _$AccelerateFromJson(json);

  Accelerate(
      {this.turn,
      this.priority,
      this.createAt,
      this.endAt,
      this.uid,
      this.timeEnd,
      this.timeStart});

  Map<String, dynamic> toJson() => _$AccelerateToJson(this);
}
