import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/scaffold_messenger_service.dart';

class DateUtil {
  static Future<DateTime?> showDateAndTimePicker(BuildContext context) async {
    DateTime? _date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: DateTime.now(),
    );

    if (_date != null) {
      TimeOfDay? _time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (_time != null) {
        return dateFromDateAndTime(_date, _time);
      } else {
        context.read(scaffoldMessengerServiceProvider).showSnackBar(SnackBar(
              content: Text('No time selected'),
            ));
      }
    } else {
      context.read(scaffoldMessengerServiceProvider).showSnackBar(SnackBar(
            content: Text('No date selected'),
          ));
    }
  }

  static DateTime dateFromDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
