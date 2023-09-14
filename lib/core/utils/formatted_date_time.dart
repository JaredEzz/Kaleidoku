import 'package:intl/intl.dart';

String formattedDateTime(DateTime dateTime) {
  DateTime now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd hh:mm');
  String formatted = formatter.format(now);
  return formatted;
}

String formatTimeOfDayString(String timeOfDayString) {
  final matches = RegExp(r'(\d+):(\d+)').firstMatch(timeOfDayString);
  if (matches != null && matches.groupCount >= 2) {
    int hour = int.parse(matches.group(1)!);
    int minute = int.parse(matches.group(2)!);

    final dateTime = DateTime(0, 0, 0, hour, minute);

    return DateFormat('hh:mm a').format(dateTime);
  }
  return '';
}
