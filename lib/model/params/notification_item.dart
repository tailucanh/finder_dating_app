import 'package:firebase_database/firebase_database.dart';

class NotificationItem {
  String? id;
  String? message;
  String? type;
  String? time;
  String? status;

  NotificationItem({this.id, this.message, this.type, this.status, this.time});

  factory NotificationItem.fromSnapshot(DataSnapshot snap) {
    Map<String, dynamic> map = {};
    for (var element in snap.children) {
      map[element.key.toString()] = element.value;
    }

    return NotificationItem(
      id: map['id'],
      message: map['message'],
      type: map['type'],
      time: map['time'],
      status: map['status'],
    );
  }
}
