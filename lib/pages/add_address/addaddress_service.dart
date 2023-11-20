import 'dart:convert';

import 'package:food_app_panel/comman/urls.dart';
import 'package:http/http.dart' as http;

class AddaadressService{
  Future<http.Response> updateUser(
    {required String gmail,
    String? lat,
    String? lng,
    String? flat,
    String? area,
    String? landmark}) async {
  return await http.put(
    Uri.parse('$apilink/wonerupdate/$gmail'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "address": [
        {
          "lat": lat,
          "lng": lng,
          "flatHouseNo": flat,
          "area": area,
          "nearbyLandmark": landmark
        }
      ]
    }),
  );
}
}