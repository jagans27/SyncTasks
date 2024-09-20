import 'package:flutter/material.dart';
import 'package:sync_tasks/util/extensions.dart';

class Util {
  static String generateTaskDayFormatString(String date) {
    try {
      final DateTime inputDate = DateTime.parse(date).toLocal();
      final DateTime now = DateTime.now().toLocal();
      final DateTime yesterday = now.subtract(const Duration(days: 1));
      final List<String> monthNames = [
        "january",
        "february",
        "march",
        "april",
        "may",
        "june",
        "july",
        "august",
        "september",
        "october",
        "november",
        "december"
      ];

      if (inputDate.year == now.year &&
          inputDate.month == now.month &&
          inputDate.day == now.day) {
        return "Today tasks";
      } else if (inputDate.year == yesterday.year &&
          inputDate.month == yesterday.month &&
          inputDate.day == yesterday.day) {
        return "Tasks of yesterday";
      } else if (inputDate.year == now.year) {
        return "Tasks of ${inputDate.day} ${monthNames[inputDate.month + 1]}";
      } else {
        return "Tasks of ${inputDate.day} ${monthNames[inputDate.month + 1]} ${inputDate.year}";
      }
    } catch (ex) {
      ex.logError();
      return "";
    }
  }

  static bool isCurrentDay(String date) {
    try {
      final DateTime inputDate = DateTime.parse(date).toLocal();
      final DateTime now = DateTime.now().toLocal();
      return inputDate.year == now.year &&
          inputDate.month == now.month &&
          inputDate.day == now.day;
    } catch (ex) {
      ex.logError();
      return false;
    }
  }

  static TimeOfDay convertStringToTimeOfDay(String timeStr) {
    try {
      final parts = timeStr.split(' ');
      final timePart = parts[0];
      final period = parts[1];

      final timeComponents = timePart.split(':');
      int hour = int.parse(timeComponents[0]);
      final minute = int.parse(timeComponents[1]);

      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }

      return TimeOfDay(hour: hour, minute: minute);
    } catch (ex) {
      ex.logError();
      return TimeOfDay.now();
    }
  }

  static DateTime parseTimeOfDayFormatedToDateTime(String time) {
    final parts = time.split(' ');
    final hm = parts[0].split(':');
    int hour = int.parse(hm[0]);
    int minute = int.parse(hm[1]);
    DateTime now = DateTime.now();

    if (parts[1] == 'PM' && hour != 12) {
      hour += 12;
    } else if (parts[1] == 'AM' && hour == 12) {
      hour = 0;
    }

    return DateTime(now.year, now.month, now.day, hour, minute); 
  }
}
