
import 'package:equatable/equatable.dart';

import '../../../../model/enums/load_state.dart';

class LoginPhoneState extends Equatable {
  final LoadStatus loadDataStatus;
  final String numberPhone;
  final String codeCountry;
  final String codeSms;
  const LoginPhoneState({
    this.loadDataStatus = LoadStatus.initial,
    this.numberPhone = "",
    this.codeCountry = "+84",
    this.codeSms = ""
  });

  @override
  List<Object?> get props => [
    loadDataStatus,
    numberPhone,
    codeCountry,
    codeSms
  ];

  LoginPhoneState copyWith({
    LoadStatus? loadDataStatus,
    String? numberPhone,
    String? codeCountry,
    String? codeSms
  }) {
    return LoginPhoneState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        numberPhone: numberPhone ?? this.numberPhone,
        codeCountry: codeCountry ?? this.codeCountry,
        codeSms: codeSms ?? this.codeSms
    );
  }
}
