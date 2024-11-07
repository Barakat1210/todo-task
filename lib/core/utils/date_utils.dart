// import 'package:intl/intl.dart';
//
// String dateFormatted(DateTime date){
//   final DateFormat formatter = DateFormat('dd / MM / yyyy ');
//   return formatter.format(date);
// }
extension FormatDate on DateTime{
  String get toFormattedDate{
    return '$day - $month - $year';
}
String get dayName{
    List<String>weekDays=['MON','TUS','WED','THU','FRI','SAT','SUN'];
    DateTime date=DateTime.now();
    return weekDays[weekday-1];
}
}