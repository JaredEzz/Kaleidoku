import 'dart:convert';

Map<String, dynamic> parser(dynamic hiveMap) {
  final jsonString = jsonEncode(hiveMap);
  return jsonDecode(jsonString);
}
