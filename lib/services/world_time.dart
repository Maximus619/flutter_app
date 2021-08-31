import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime {
  String location;
  String time = '0';
  String flag;
  String url;
  bool isDaytime = false;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    http.Response response =
        await http.get(Uri.https('worldtimeapi.org', '$url'));
    Map data = jsonDecode(response.body.toString());

    String datetime = data['datetime'].toString();
    String offset = data['utc_offset'].substring(1, 3).toString();
    String offmin = data['utc_offset']
        .substring(
          4,
        )
        .toString();

    DateTime now = DateTime.parse(datetime);
    var today =
        now.add(Duration(hours: int.parse(offset), minutes: int.parse(offmin)));
    isDaytime = today.hour > 6 && today.hour < 18 ? true : false;
    time = DateFormat.jm().format(today).toString();
  }
}
