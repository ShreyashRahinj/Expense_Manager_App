String convertDateTimeToString(DateTime dateTime) {
  String year = '${dateTime.year}/';

  String month = '${dateTime.month}/';
  if (month.length == 1) {
    month = '0$month';
  }

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

String getTimeFromDateTime(DateTime dateTime) {
  String hour = '${dateTime.hour}:';
  if (hour.length == 1) {
    hour = '0$hour';
  }
  String minute = dateTime.minute.toString();
  if (minute.length == 1) {
    minute = '0$minute';
  }
  return hour + minute;
}
