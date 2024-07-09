import 'package:chat_app/services/time_service.dart';

extension GetImage on String {
  String withImage({String type = "png"}) => 'assets/images/$this.$type';

  String withIcon({String type = "svg"}) => 'assets/icons/$this.$type';

  String withIconPNG({String type = "png"}) => 'assets/icons/$this.$type';

// String withTrophy({String type = "png"}) => 'assets/trophy/$this.$type';
// String withRiv({String type = "riv"}) => 'assets/riv/$this.$type';
  String withLottie({String type = "json"}) => 'assets/lottie/$this.$type';
}

extension Valid on String? {
  bool isValidEmail() => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this ?? '');

  bool isValidPhoneNumber() =>
      RegExp(r'^[+]*[(]?[0-9]{1,4}[)]?[-\s./0-9]*$').hasMatch(this ?? '');
}

extension LanguageConvert on String? {
  String? get getTitle => {
        'vi': "🇻🇳 Vietnamese",
        'en': "🇺🇸 English",
      }[this];
  String? get getIcon => {
        'vi': "Vietnamese",
        'en': "English",
      }[this];
}

extension DateTimeExtensions on String {
  bool isExpired() {
    DateTime targetTime = DateTime.fromMillisecondsSinceEpoch(int.parse(this));
    if (targetTime.isBefore(timeService.timeNow)) {
      return true; // Đã hết hạn
    } else {
      return false; // Còn hạn
    }
  }
}
