import 'package:intl/intl.dart';

class TimeFormat{
  static String  currentTime(myDateTime) {
    var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    var utcDate   = dateFormat.format(DateTime.parse(myDateTime));
    DateTime dateTime= dateFormat.parse(utcDate,true);
    return DateFormat('dd MMM, hh:mm').format(dateTime);
  }

  static String convertInDate(date){
    DateTime dateTime = DateTime.parse(date);

    // Format the date
    return DateFormat('yyyy MMMM dd').format(dateTime);
  }

  static String convertInTimeWithAMPM(timeString){
    DateTime time = DateFormat('HH:mm:ss').parse(timeString);
    // Format the date
    return DateFormat('h:mm a').format(time);
  }

  static String convertInTime(timeString){
    var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    var utcDate   = dateFormat.format(DateTime.parse(timeString));
    DateTime dateTime= dateFormat.parse(utcDate,true);
    // Format the date
    return DateFormat('h:mm').format(dateTime);
  }
}