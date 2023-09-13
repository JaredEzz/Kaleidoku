import 'package:intl/intl.dart';

String formattedDateTime(DateTime dateTime) {
  DateTime now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd hh:mm');
  String formatted = formatter.format(now);
  return formatted;
}
