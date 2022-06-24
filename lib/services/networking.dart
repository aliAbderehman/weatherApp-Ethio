import 'package:http/http.dart' as http;
import 'dart:convert';
import 'location.dart';

class NetworkHelper {
  var url;
  NetworkHelper({this.url});
  double? latitude;
  double? longitude;

  Future getData() async {
    Location location = Location();

    await location.getPosition();
    latitude = location.latitude;
    longitude = location.longitude;
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      // print(data);

      return data;
    } else {
      return response.statusCode;
    }
  }
}
