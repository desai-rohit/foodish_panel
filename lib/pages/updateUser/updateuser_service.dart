import 'dart:convert';
import 'package:food_app_panel/comman/urls.dart';
import 'package:http/http.dart' as http;


class UpdateUserServices{
  Future<http.Response> updateUsername({
  required String gmail,
  String? ownersName,
  String? restaurantName,
}) async {
  return await http.put(
    Uri.parse('$apilink/wonerupdate/$gmail'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "ownersName": ownersName,
      "restaurantName": restaurantName,
    }),
  );
}
}