
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

class CommonUtils {
  static String capitalizeFirstLetter(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  static String? dateFormatEMD(String dateTime) {

    if (dateTime == null) return null;
    String timestamp = dateTime;
    DateTime tempDate = DateTime.parse(timestamp);
    if (timestamp.contains("z") || timestamp.contains("Z")) {
    } else {
      tempDate = DateTime.parse("${timestamp}Z");
    }
    final formatter = DateFormat("dd/MM/yyyy"); // Customize the format as needed
    return formatter.format(tempDate.toLocal());
  }

  static String? dateFormatTime(String dateTime) {
    if (dateTime == null) return null;
    String timestamp = dateTime;
    DateTime tempDate = DateTime.parse(timestamp);
    if (timestamp.contains("z") || timestamp.contains("Z")) {
    } else {
      tempDate = DateTime.parse(timestamp + "Z");
    }
    final formatter = DateFormat("hh:mm a"); // Customize the format as needed
    return formatter.format(tempDate.toLocal());
  }


}
