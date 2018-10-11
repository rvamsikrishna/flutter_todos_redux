import 'package:flutter/material.dart';

String formattedDateTime(DateTime date, TimeOfDay time, BuildContext context) {
  String result = '';
  final now = DateTime.now();
  final endOfToday = DateTime.utc(now.year, now.month, now.day, 24);
  if (date.isBefore(endOfToday)) {
    result += '';
  } else {
    result += ' , ${date.day}-${_month(date.month)}-${date.year}';
  }
  return result += ' , ${time.format(context)}';
}

String _month(int month) {
  String res;
  switch (month) {
    case 1:
      res = 'jan';
      break;
    case 2:
      res = 'feb';
      break;
    case 3:
      res = 'mar';
      break;
    case 4:
      res = 'apr';
      break;
    case 5:
      res = 'may';
      break;
    case 6:
      res = 'jun';
      break;
    case 7:
      res = 'jul';
      break;
    case 8:
      res = 'aug';
      break;
    case 9:
      res = 'sep';
      break;
    case 10:
      res = 'oct';
      break;
    case 11:
      res = 'nov';
      break;
    case 12:
      res = 'dec';
      break;
  }
  return res;
}
