import 'package:intl/intl.dart';

List<String> past7FullDates() {
  final now = DateTime.now();
  final formatter = DateFormat('dd-MM-yyyy'); // Use 'dd-MM-yyyy' format

  final past7Days = List.generate(7, (i) => now.subtract(Duration(days: i)));

  return past7Days
      .map((date) => formatter.format(date))
      .toList()
      .reversed
      .toList();
}

List<int> past7Dates() {
  final now = DateTime.now();
  final formatter = DateFormat('dd');

  final past7datess = List.generate(7, (i) => now.subtract(Duration(days: i)));

  return past7datess
      .map((date) => int.parse(formatter.format(date)))
      .toList()
      .reversed
      .toList();
}

List<String> past7Days() {
  final now = DateTime.now();
  final formatter = DateFormat.E();

  final past7Days = List.generate(7, (i) => now.subtract(Duration(days: i)));

  return past7Days
      .map((date) => formatter.format(date))
      .toList()
      .reversed
      .toList();
}

// return todays date formatted as yyyymmdd
String todaysDateFormatted() {
  // today
  var dateTimeObject = DateTime.now();

  // year in the format yyyy
  String year = dateTimeObject.year.toString();

  // month in the format mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in the format dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

// convert string yyyymmdd to DateTime object
DateTime createDateTimeObject(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}

// convert DateTime object to string yyyymmdd
String convertDateTimeToString(DateTime dateTime) {
  // year in the format yyyy
  String year = dateTime.year.toString();

  // month in the format mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in the format dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
