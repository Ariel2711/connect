// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

dateFormatter(DateTime? date) {
  if (date is DateTime)
    return DateFormat.yMMMMEEEEd('id').format(date);
  else
    return '';
}

dateMonthFormatter(DateTime? date) {
  if (date is DateTime)
    return DateFormat.MMMM('id').format(date);
  else
    return '';
}

dateTimeFormatter(DateTime? date) {
  if (date is DateTime) {
    return DateFormat('d MMM y H.mm').format(date);
    // return "${DateFormat.yMMMMd('id').format(date)} ${DateFormat.Hm('id').format(date)}";
  } else
    return '';
}

dateNormalFormat(DateTime? date) {
  if (date is DateTime)
    return DateFormat.yMd('id').format(date);
  else
    return '';
}

timeSecondFormatter(DateTime? date) {
  if (date is DateTime)
    return DateFormat.jms('id').format(date);
  else
    return '';
}

String timeFormatter(DateTime? date,
    {TimeOfDay? time, bool withSecond = false}) {
  if (time is TimeOfDay) {
    date = DateTime(1, 1, 1, time.hour, time.minute);
  }
  if (date is DateTime) {
    return withSecond
        ? DateFormat("H:m:s", "id").format(date)
        : DateFormat("HH:mm", "id").format(date);
  }

  return '';
}

String tipeMediaToStr(int? jenis) {
  switch (jenis) {
    case 10:
      return 'Foto';
    case 20:
      return 'Video';
    default:
      return '';
  }
}
