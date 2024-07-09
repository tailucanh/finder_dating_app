import 'package:json_annotation/json_annotation.dart';

part 'tokens.g.dart';

@JsonSerializable()
class Tokens {
  String? idUser;
  String? token;
  int? timeActive;
  int? time;
  bool? isProfileVerified;


  Tokens({this.idUser, this.token, this.timeActive, this.time,this.isProfileVerified});

  factory Tokens.fromJson(Map<String, dynamic> json) => _$TokensFromJson(json);

  Map<String, dynamic> toJson() => _$TokensToJson(this);

  Tokens copyWith({
    String? idUser,
    String? token,
    int? timeActive,
    int? time,
    bool? isProfileVerified
  }) {
    return Tokens(
      idUser: idUser ?? this.idUser,
      token: token ?? this.token,
      timeActive: timeActive ?? this.timeActive,
      time: time ?? this.time,
      isProfileVerified: isProfileVerified ?? this.isProfileVerified,
    );
  }
//
}
