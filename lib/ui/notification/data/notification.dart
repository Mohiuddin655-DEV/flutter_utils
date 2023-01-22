import 'package:intl/intl.dart';

class NotificationData {
  final String? id;
  final int timeMS;
  final String? name;
  final String? title;
  final String? message;
  final String? photo;
  final String? video;
  final bool isNew;

  const NotificationData({
    this.id,
    this.timeMS = 0,
    this.name,
    this.title,
    this.message,
    this.photo,
    this.video,
    this.isNew = false,
  });

  String get time {
    final date = DateTime.fromMillisecondsSinceEpoch(timeMS);
    return DateFormat("hh:mm a").format(date);
  }

  String get date {
    final date = DateTime.fromMillisecondsSinceEpoch(timeMS);
    return DateFormat("MMM dd, yyyy").format(date);
  }

  static List<NotificationData> notifications = [
    NotificationData(
      isNew: true,
      timeMS: DateTime.now().millisecondsSinceEpoch,
      title: "Your password has been successfully changed.",
      message: "Your password has been successfully changed.",
    ),
    NotificationData(
      isNew: true,
      timeMS: DateTime.now().millisecondsSinceEpoch,
      name: "Kevin Dukkon",
      title: "Thank you for booking a meeting with us.",
      message: "Thank you for booking a meeting with us.",
      photo: "https://pbs.twimg.com/media/FhC3LvHXkAEMEUZ.png",
    ),
    NotificationData(
      timeMS: DateTime.now().millisecondsSinceEpoch,
      name: "Markus Gavrilov",
      title: "Great news! We are launching our 5th fund: DLE Senior Living.",
      message: "Great news! We are launching our 5th fund: DLE Senior Living.",
      photo: "https://i.pinimg.com/736x/c5/c6/3c/c5c63c1cc5bfca51ffc0ceb705dbd553.jpg",
    ),
    NotificationData(
      isNew: true,
      timeMS: DateTime.now().millisecondsSinceEpoch,
      title: "Your password has been successfully changed.",
      message: "Your password has been successfully changed.",
    ),
    NotificationData(
      timeMS: DateTime.now().millisecondsSinceEpoch,
      name: "Kevin Dukkon",
      title: "Thank you for booking a meeting with us.",
      message: "Thank you for booking a meeting with us.",
      photo: "https://pbs.twimg.com/media/FhC3LvHXkAEMEUZ.png",
    ),
    NotificationData(
      timeMS: DateTime.now().millisecondsSinceEpoch,
      name: "Markus Gavrilov",
      title: "Great news! We are launching our 5th fund: DLE Senior Living.",
      message: "Great news! We are launching our 5th fund: DLE Senior Living.",
      photo: "https://i.pinimg.com/736x/c5/c6/3c/c5c63c1cc5bfca51ffc0ceb705dbd553.jpg",
    ),
    NotificationData(
      timeMS: DateTime.now().millisecondsSinceEpoch,
      title: "Your password has been successfully changed.",
      message: "Your password has been successfully changed.",
    ),
    NotificationData(
      timeMS: DateTime.now().millisecondsSinceEpoch,
      name: "Kevin Dukkon",
      title: "Thank you for booking a meeting with us.",
      message: "Thank you for booking a meeting with us.",
      photo: "https://pbs.twimg.com/media/FhC3LvHXkAEMEUZ.png",
    ),
    NotificationData(
      timeMS: DateTime.now().millisecondsSinceEpoch,
      name: "Markus Gavrilov",
      title: "Great news! We are launching our 5th fund: DLE Senior Living.",
      message: "Great news! We are launching our 5th fund: DLE Senior Living.",
      photo: "https://i.pinimg.com/736x/c5/c6/3c/c5c63c1cc5bfca51ffc0ceb705dbd553.jpg",
    ),
    NotificationData(
      timeMS: DateTime.now().millisecondsSinceEpoch,
      title: "Your password has been successfully changed.",
      message: "Your password has been successfully changed.",
    ),
    NotificationData(
      timeMS: DateTime.now().millisecondsSinceEpoch,
      name: "Kevin Dukkon",
      title: "Thank you for booking a meeting with us.",
      message: "Thank you for booking a meeting with us.",
      photo: "https://pbs.twimg.com/media/FhC3LvHXkAEMEUZ.png",
    ),
    NotificationData(
      timeMS: DateTime.now().millisecondsSinceEpoch,
      name: "Markus Gavrilov",
      title: "Great news! We are launching our 5th fund: DLE Senior Living.",
      message: "Great news! We are launching our 5th fund: DLE Senior Living.",
      photo: "https://i.pinimg.com/736x/c5/c6/3c/c5c63c1cc5bfca51ffc0ceb705dbd553.jpg",
    ),
  ];
}
