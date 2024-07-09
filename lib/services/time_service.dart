import 'dart:developer';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

late TimeService timeService;

class TimeService {
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterTimezone.getLocalTimezone()));
  }

  tz.TZDateTime get timeNow => tz.TZDateTime.now(tz.local);

  TimeService() {
    _configureLocalTimeZone();
  }

  bool get hasAccelerate =>
      int.parse(helpersFunctions.timeEnd) >= timeNow.millisecondsSinceEpoch;

  int get timePlay {
    if (hasAccelerate) {
      int minutes1 = int.parse(helpersFunctions.timeEnd) ~/ 1000 ~/ 60;

      int minutes2 = timeNow.millisecondsSinceEpoch ~/ 1000 ~/ 60;
      return minutes1 - minutes2;
    } else {
      return 0;
    }
  }

  double get timeRunning {
    if (hasAccelerate) {
      int minutes1 = int.parse(helpersFunctions.timeEnd) ~/ 1000 ~/ 60;

      int minutes2 = timeNow.millisecondsSinceEpoch ~/ 1000 ~/ 60;

      log("message mini ${minutes1 - minutes2}");

      return (minutes1 - minutes2) / 30;
    } else {
      return 0.0;
    }
  }
}
