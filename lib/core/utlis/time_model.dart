import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  DateTime toDateTime(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      this.hour,
      this.minute,
    );
  }
}

class TimeModel {
  TimeModel({required this.currentTime});

  final TimeOfDay currentTime;
}

class TimeSlots {
  static List<TimeModel> morningSlot = <TimeModel>[
    TimeModel(
      currentTime: const TimeOfDay(hour: 8, minute: 0),
    ),
    TimeModel(
      currentTime: const TimeOfDay(hour: 10, minute: 0),
    ),
    TimeModel(
      currentTime: const TimeOfDay(hour: 11, minute: 0),
    ),
    TimeModel(
      currentTime: const TimeOfDay(hour: 1, minute: 30),
    ),
  ];

  static List<TimeModel> noonSlot = <TimeModel>[
    TimeModel(
      currentTime: const TimeOfDay(hour: 13, minute: 0),
    ),
    TimeModel(
      currentTime: const TimeOfDay(hour: 15, minute: 0),
    ),
    TimeModel(
      currentTime: const TimeOfDay(hour: 17, minute: 0),
    ),
    TimeModel(
      currentTime: const TimeOfDay(hour: 18, minute: 30),
    ),
  ];

  static List<TimeModel> nightSlot = <TimeModel>[
    TimeModel(
      currentTime: const TimeOfDay(hour: 20, minute: 0),
    ),
    TimeModel(
      currentTime: const TimeOfDay(hour: 21, minute: 0),
    ),
    TimeModel(
      currentTime: const TimeOfDay(hour: 23, minute: 0),
    ),
  ];
}
