import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediplus/core/enum/user_state.dart';

final currencyFormat = NumberFormat("#,##0.00", "en_US");

class Utils {
  static String formatNumber(int number) {
    return NumberFormat.compact().format(number);
  }

  static int calculateAge(DateTime dob) {
    final now = DateTime.now();
    final age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      return age - 1;
    }
    return age;
  }

  static Color getColor(String status) {
    if (status == 'pending') {
      return Colors.orange;
    } else if (status == 'accepted') {
      return Colors.orange;
    } else if (status == 'in progress') {
      return Colors.green;
    } else if (status == 'cancelled') {
      return Colors.red;
    } else if (status == "completed" || status == 'finished') {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;

      case UserState.Online:
        return 1;

      default:
        return 2;
    }
  }

  static UserState numToState(int number) {
    switch (number) {
      case 0:
        return UserState.Offline;

      case 1:
        return UserState.Online;

      default:
        return UserState.Waiting;
    }
  }
}
